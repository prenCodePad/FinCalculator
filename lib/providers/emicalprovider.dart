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
            divisions: 23,
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

  List<ScheduledEMI> get rapaymentSchedule => _getRepaymentSchedule();
  bool _isTenureInMonths = false;
  bool get isTenureInMonths => _isTenureInMonths;
  double get loanAmount => _loanAmount;
  double get interestRate => _interestRate;
  double get tenure => _tenure;
  double get tenureInMonths => tenure * 12;

  double get rateOFAnnualInterest =>
      tenure == 0 ? 0 : (interestRate * 0.01) / 12;

  double get emi {
    if (rateOFAnnualInterest == 0.0) {
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

  void setValue(int value, isSlider, attribute) {
    if (attribute == "Loan Amount") {
      setLoanAmount(value.toDouble());
    } else if (attribute == "Interest Rate") {
      setInterest(value.toDouble());
    } else {
      setTenure(value.toDouble());
    }

    if (isSlider) {
      _controllerMap[attribute]!.text = value.toString();
    }

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

    for (int i = 1; i <= tenureInMonths; i++) {
      double interest;
      double principal;
      ScheduledEMI installment = new ScheduledEMI();
      interest = rateOFAnnualInterest * outstandingAmount;
      principal = emi - interest;
      outstandingAmount = outstandingAmount - principal;
      installment.installmentDate = i == 1
          ? DateTime.now()
          : Jiffy(DateTime.now()).add(months: i).dateTime;
      installment.interest = interest;
      installment.outstandingBalance = outstandingAmount;
      installment.principal = principal;
      emiSchedule.add(installment);
    }

    return emiSchedule;
  }

  Map<String, double> get dataMap => {
        "Principal Loan Amount": loanAmount.isNaN ? 0 : loanAmount,
        "Total Interest": interestPayable.isNaN ? 0 : interestPayable
      };
}
