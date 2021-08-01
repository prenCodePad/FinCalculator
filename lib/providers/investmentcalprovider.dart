import 'dart:math';
import 'package:fincalculator/Models/CalculationVariables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvestmentProvider with ChangeNotifier {
  Map<String, CalculationVariables> get investmentVariables => {
        typeOfInvestment == "SIP" ? "Monthly Investment" : "Total Investment":
            CalculationVariables(
                controller: investmentController,
                divisions: 200,
                max: 200000,
                min: 0,
                representation: "₹"),
        "Est Return Rate": CalculationVariables(
            controller: returnRateController,
            divisions: 60,
            max: 30,
            min: 0,
            representation: "%"),
        "Time Period": CalculationVariables(
            controller: timePeriodController,
            divisions: 28,
            max: 30,
            min: 0,
            representation: "Yr"),
      };

  double _investedValue = 500;
  double _rateOfInterest = 2;
  double _timeperiod = 1;
  String _typeOfInvestment = "SIP";
  int _key = 0;
  TextEditingController _investmentController =
      new TextEditingController(text: "500");
  TextEditingController _returnRateController =
      new TextEditingController(text: "2");
  TextEditingController _timePeriodController =
      new TextEditingController(text: "1");

  TextEditingController get investmentController => _investmentController;

  TextEditingController get returnRateController => _returnRateController;

  TextEditingController get timePeriodController => _timePeriodController;

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
  double get maturityForSip {
    if (rateOfInterestMonthly == 0 || rateOfInterestMonthly == 0.0) {
      return investedValue * timeperiodMonths;
    } else {
      return investedValue *
          ((pow(1 + rateOfInterestMonthly, timeperiodMonths) - 1) /
              rateOfInterestMonthly) *
          (1 + rateOfInterestMonthly);
    }
  }

  double get maturityForLumpSum =>
      investedValue * (pow(1 + rateOfInterestAnnually, timePeriodYears));

  double get totalinvestedAmountSIP => _investedValue * _timeperiod * 12;

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

  void setValue(double value, isSlider, attribute) {
    if (attribute == "Monthly Investment" || attribute == "Total Investment") {
      setInvestedValue(value);
    } else if (attribute == "Est Return Rate") {
      setRateofInterest(value);
    } else {
      setTimePeriod(value);
    }
    if (isSlider) {
      _controllerMap[attribute]!.text = attribute == "Est Return Rate"
          ? value.toString()
          : value.round().toString();
    }

    notifyListeners();
  }

  void setInvestedValue(value) => _investedValue = value;

  void setRateofInterest(value) => _rateOfInterest = value;

  void setTimePeriod(value) => _timeperiod = value;

  Map<String, double> get dataMap => {
        "Invested Amount": typeOfInvestment == "SIP"
            ? totalinvestedAmountSIP.isNaN
                ? investedValue
                : totalinvestedAmountSIP
            : investedValue,
        "Est Returns": typeOfInvestment == "SIP"
            ? returnsForSip.isNaN
                ? 0
                : returnsForSip
            : returnsForLumpsum,
      };
}
