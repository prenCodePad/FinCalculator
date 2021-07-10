import 'dart:math';
import 'package:fincalculator/Models/CalculationVariables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvestmentProvider with ChangeNotifier {
  Map<String, CalculationVariables> get investmentVariables => {
        typeOfInvestment == "SIP" ? "Monthly Investment" : "Total Investment":
            CalculationVariables(
                controller: investmentController,
                divisions: 399,
                max: 200000,
                min: 500,
                representation: "₹"),
        "Est Return Rate": CalculationVariables(
            controller: returnRateController,
            divisions: 27,
            max: 30,
            min: 2,
            representation: "%"),
        "Time Period": CalculationVariables(
            controller: timePeriodController,
            divisions: 28,
            max: 30,
            min: 1,
            representation: "Yr"),
      };

  double _investedValue = 500;
  double _rateOfInterest = 2;
  double _timeperiod = 1;
  String _typeOfInvestment = "LUMPSUM";
  int _key = 0;

  TextEditingController get investmentController =>
      new TextEditingController(text: investedValue.toInt().toString());

  TextEditingController get returnRateController =>
      new TextEditingController(text: displayRateOfInterest.toInt().toString());
  TextEditingController get timePeriodController =>
      new TextEditingController(text: timePeriodYears.toInt().toString());

  //getters
  List<String> get typesOfInvestment => ["SIP", "LUMPSUM"];
  List<String> get investmentAtributes => [
        "Monthly Investment",
        "Total Investment",
        "Est Return Rate",
        "Time Period"
      ];
  Map<String, TextEditingController> get _controllerMap => {
        "Monthly Investment": investmentController,
        "Total Investment": investmentController,
        "Est Return Rate": returnRateController,
        "Time Period": timePeriodController
      };
  int get key => _key;
  String get typeOfInvestment => _typeOfInvestment;
  double get investedValue => _investedValue;
  double get rateOfInterestMonthly => (_rateOfInterest * 0.01) / 12;
  double get rateOfInterestAnnually => _rateOfInterest * 0.01;
  double get displayRateOfInterest => _rateOfInterest;
  double get timeperiodMonths => _timeperiod * 12;
  double get timePeriodYears => _timeperiod;
  double get maturityForSip =>
      investedValue *
      ((pow(1 + rateOfInterestMonthly, timeperiodMonths) - 1) /
          rateOfInterestMonthly) *
      (1 + rateOfInterestMonthly);

  double get maturityForLumpSum =>
      investedValue * (pow(1 + rateOfInterestAnnually, timePeriodYears));

  double get totalinvestedAmountSIP {
    print(
        "invested $_investedValue timeperiod $_timeperiod total ${_investedValue * _timeperiod * 12}");
    return _investedValue * _timeperiod * 12;
  }

  double get returnsForSip => maturityForSip - totalinvestedAmountSIP;
  double get returnsForLumpsum => maturityForLumpSum - investedValue;

  double get finalTotalAmount =>
      typeOfInvestment == "SIP" ? maturityForSip : maturityForLumpSum;

  double get finalInvestedAmount =>
      typeOfInvestment == "SIP" ? totalinvestedAmountSIP : investedValue;

  double get finalReturns =>
      typeOfInvestment == "SIP" ? returnsForSip : returnsForLumpsum;

  double sliderValue(String attribute) {
    return attribute == "Monthly Investment" || attribute == "Total Investment"
        ? investedValue
        : attribute == "Est Return Rate"
            ? displayRateOfInterest
            : timePeriodYears;
  }

  //Setters
  void setKey() {
    _key = _key + 1;
  }

  void setTypesOfInvestment(type) {
    _typeOfInvestment = type;
    notifyListeners();
  }

  void setValue(value, isSlider, attribute) {
    switch (attribute) {
      case "Monthly Investment":
        setInvestedValue(value);
        break;
      case "Total Investment":
        setInvestedValue(value);
        break;
      case "Est Return Rate":
        setRateofInterest(value);
        break;
      case "Time Period":
        setTimePeriod(value);
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

  void setInvestedValue(value) {
    if (value > 200000) {
      investmentController.text = 200000.toString();
      _investedValue = 200000.0;
    } else if (value < 500) {
      investmentController.text = 500.toString();
      _investedValue = 500.0;
    } else {
      _investedValue = value;
    }
  }

  void setRateofInterest(value) {
    if (value > 30) {
      returnRateController.text = 30.toString();
      _rateOfInterest = 30.0;
    } else if (value < 1) {
      returnRateController.text = 1.toString();
      _rateOfInterest = 1.0;
    } else {
      _rateOfInterest = value;
    }
  }

  void setTimePeriod(value) {
    if (value > 30) {
      timePeriodController.text = 30.toString();
      _timeperiod = 30.0;
    } else if (value < 1) {
      timePeriodController.text = 1.toString();
      _timeperiod = 1.0;
    } else {
      _timeperiod = value;
    }
  }

  Map<String, double> get dataMap => {
        "Invested Amount":
            typeOfInvestment == "SIP" ? totalinvestedAmountSIP : investedValue,
        "Est Returns":
            typeOfInvestment == "SIP" ? returnsForSip : returnsForLumpsum,
      };
}
