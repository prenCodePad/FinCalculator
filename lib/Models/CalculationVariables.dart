import 'package:flutter/cupertino.dart';

class CalculationVariables {
  CalculationVariables(
      {this.divisions,
      this.max,
      this.min,
      this.representation,
      this.controller});

  double? min;
  double? max;
  int? divisions;
  String? representation;
  TextEditingController? controller;
}
