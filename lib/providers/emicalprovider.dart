import 'dart:math';
import 'package:fincalculator/Models/CalculationVariables.dart';
import 'package:fincalculator/Models/scheduledemi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class EMIProvider extends ChangeNotifier {
  List<String> get emiAttributes => [
        "Loan Amount",
        "Interest Rate",
        "Loan Tenure",
      ];

  Map<String, CalculationVariables> get emiVariables => {
        "Loan Amount": CalculationVariables(
            controller: loanAmountController,
            divisions: 10000,
            max: 10000000,
            min: 0,
            representation: "₹"),
        "Interest Rate": CalculationVariables(
            controller: interestController,
            divisions: 40,
            max: 20,
            min: 0,
            representation: "%"),
        "Loan Tenure": CalculationVariables(
            controller: tenureController,
            divisions: 28,
            max: 30,
            min: 0,
            representation: "Yr"),
      };

  TextEditingController _loanAmountController =
      new TextEditingController(text: "1000");
  TextEditingController _interestController =
      new TextEditingController(text: "5");
  TextEditingController _tenureController =
      new TextEditingController(text: "1");

  TextEditingController get loanAmountController => _loanAmountController;

  TextEditingController get interestController => _interestController;

  TextEditingController get tenureController => _tenureController;

  double _loanAmount = 1000;
  double _interestRate = 5;
  double _tenure = 1;
  double _tenureInMonths = 12;

  //getters

  Map<String, TextEditingController> get _controllerMap => {
        "Loan Amount": loanAmountController,
        "Interest Rate": interestController,
        "Loan Tenure": tenureController,
      };

  List<ScheduledEMI> get rapaymentSchedule =>
      _isReportForyear ? _getRepaymentScheduleYear() : _getRepaymentSchedule();

  bool _isTenureInMonths = false;
  bool _isReportForyear = false;
  bool get isTenureInMonths => _isTenureInMonths;
  bool get isReportForyear => _isReportForyear;
  double get loanAmount => _loanAmount;
  double get interestRate => _interestRate;
  double get tenure => _tenure;
  double get tenureInMonths => tenure * 12;

  double get rateOFAnnualInterest => (interestRate * 0.01) / 12;

  double get emi {
    print("nnn$tenure");
    if (rateOFAnnualInterest == 0.0 || tenure.toInt() == 0) {
      return tenure.toInt() == 0 ? 0 : loanAmount / tenureInMonths;
    } else {
      return loanAmount *
          rateOFAnnualInterest *
          (pow(1 + rateOFAnnualInterest, tenureInMonths) /
              (pow(1 + rateOFAnnualInterest, tenureInMonths) - 1));
    }
  }

  double get interestPayable =>
      emi == 0 ? 0 : (emi * tenureInMonths) - loanAmount;
  double get totalPayable => interestPayable + loanAmount;

  //setters

  void setValue(double value, isSlider, attribute) {
    if (attribute == "Loan Amount") {
      setLoanAmount(value);
    } else if (attribute == "Interest Rate") {
      setInterest(value);
    } else {
      setTenure(value.round().toDouble());
    }

    if (isSlider) {
      _controllerMap[attribute]!.text = attribute == "Interest Rate"
          ? value.toString()
          : value.round().toString();
    }

    notifyListeners();
  }

  void setisReportforMonth() {
    _isReportForyear = !_isReportForyear;
    notifyListeners();
  }

  void setLoanAmount(value) => _loanAmount = value;

  void setInterest(value) => _interestRate = value;

  void setTenure(value) => _tenure = value;

  double sliderValue(String attribute) {
    return attribute == "Loan Amount"
        ? loanAmount
        : attribute == "Interest Rate"
            ? interestRate
            : tenure;
  }

  List<ScheduledEMI> _getRepaymentSchedule() {
    var outstandingAmount = loanAmount;
    List<ScheduledEMI> emiSchedule = [];

    for (int i = 0; i < tenureInMonths; i++) {
      double interest;
      double principal;
      ScheduledEMI installment = new ScheduledEMI();
      interest = rateOFAnnualInterest * outstandingAmount;
      principal = emi - interest;
      outstandingAmount = outstandingAmount - principal;
      installment.installmentDate = i == 0
          ? DateTime.now()
          : Jiffy(DateTime.now()).add(months: i).dateTime;
      installment.interest = interest;
      installment.outstandingBalance = outstandingAmount;
      installment.principal = principal;
      emiSchedule.add(installment);
    }

    return emiSchedule;
  }

  List<DateTime> _getAllYears() {
    List<DateTime> allYears = [];
    var date = new DateTime.now();
    for (int i = 0; i <= tenure; i++) {
      DateTime year = DateTime(date.year + i, date.month, date.day);
      allYears.add(year);
    }

    return allYears;
  }

  Map<DateTime, List<ScheduledEMI>> _getRepaymentScheduleYear1() {
    List<ScheduledEMI> yearEmi = _getRepaymentSchedule();
    for (int i = 0; i < yearEmi.length; i++) {}

    return {};
  }

  List<ScheduledEMI> _getRepaymentScheduleYear() {
    List<ScheduledEMI> monthlyEmi = _getRepaymentSchedule();
    List<DateTime> years = _getAllYears();
    List<ScheduledEMI> yearlyEmi = [];
    print("1111${years.length}");
    for (int i = 0; i < years.length; i++) {
      ScheduledEMI emi = new ScheduledEMI();
      emi.installmentDate = years[i];
      print("${years[i]}");
      emi.interest = monthlyEmi
          .where((element) => element.installmentDate!.year == years[i].year)
          .fold(0, (previousValue, element) {
        print("${element.interest}");
        return previousValue + element.interest.round();
      });
      emi.outstandingBalance = monthlyEmi
          .where((element) => element.installmentDate!.year == years[i].year)
          .last
          .outstandingBalance
          .roundToDouble();
      emi.principal = monthlyEmi
          .where((element) => element.installmentDate!.year == years[i].year)
          .fold(
              0,
              (previousValue, element) =>
                  previousValue + element.principal.round());
      yearlyEmi.add(emi);
      print("$emi");
    }

    return yearlyEmi;
  }

  Map<String, double> get dataMap => {
        "Principal Loan Amount": loanAmount.isNaN ? 0 : loanAmount,
        "Total Interest": interestPayable.isNaN ? 0 : interestPayable
      };
}
