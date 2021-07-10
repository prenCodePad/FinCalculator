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
            divisions: 9999,
            max: 10000000,
            min: 1000,
            representation: "₹"),
        "Interest Rate": CalculationVariables(
            controller: interestController,
            divisions: 23,
            max: 20,
            min: 5,
            representation: "%"),
        "Loan Tenure": CalculationVariables(
            controller: tenureController,
            divisions: 28,
            max: 30,
            min: 1,
            representation: "Yr"),
      };

  TextEditingController get loanAmountController =>
      new TextEditingController(text: loanAmount.toInt().toString());

  TextEditingController get interestController =>
      new TextEditingController(text: interestRate.toInt().toString());
  TextEditingController get tenureController => new TextEditingController(
      text: isTenureInMonths
          ? tenureInMonths.toInt().toString()
          : tenure.toInt().toString());

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
  double get tenureInMonths =>
      isTenureInMonths ? _tenureInMonths : _tenure * 12;
  double get rateOFAnnualInterest => (_interestRate * 0.01) / 12;
  double get emi =>
      loanAmount *
      rateOFAnnualInterest *
      (pow(1 + rateOFAnnualInterest, tenureInMonths) /
          (pow(1 + rateOFAnnualInterest, tenureInMonths) - 1));
  double get interestPayable => (emi * tenureInMonths) - loanAmount;
  double get totalPayable => interestPayable + loanAmount;

  //setters

  void setValue(value, isSlider, attribute) {
    switch (attribute) {
      case "Loan Amount":
        setLoanAmount(value);
        break;
      case "Interest Rate":
        setInterest(value);
        break;
      case "Loan Tenure":
        setTenure(value);
        break;
      default:
        {
          //statements;
        }
        break;
    }

    if (isSlider) {
      _controllerMap[attribute]!.text = value.toString();
    }

    notifyListeners();
  }

  void setLoanAmount(value) {
    if (value > 10000000) {
      loanAmountController.text = 10000000.toString();
      _loanAmount = 10000000.0;
    } else if (value < 1000) {
      loanAmountController.text = 1000.toString();
      _loanAmount = 1000.0;
    } else {
      _loanAmount = value;
    }
  }

  void setInterest(value) {
    if (value > 20) {
      interestController.text = 20.toString();
      _interestRate = 20.0;
    } else if (value < 5) {
      interestController.text = 5.toString();
      _interestRate = 5.0;
    } else {
      _interestRate = value;
    }
  }

  void setTenure(value) {
    if (value > 30) {
      tenureController.text = 30.toString();
      _tenure = 30.0;
    } else if (value < 1) {
      tenureController.text = 1.toString();
      _tenure = 1.0;
    } else {
      _tenure = value;
    }
  }

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

  Map<String, double> get dataMap =>
      {"Principal Loan Amount": loanAmount, "Total Interest": interestPayable};
}
