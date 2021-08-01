import 'package:fincalculator/Widgets/financeform.dart';
import 'package:flutter/material.dart';

class SliderInput extends StatelessWidget {
  final String heading;
  final String? label;
  final double sliderValue;
  final TextEditingController controller;
  final double min;
  final double max;
  final int divisions;
  final Function action;

  SliderInput({
    Key? key,
    required this.heading,
    this.label,
    required this.sliderValue,
    required this.controller,
    required this.min,
    required this.max,
    required this.divisions,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        FinanceForm(
            heading: heading,
            controller: controller,
            label: label,
            action: action,
            max: max,
            min: min),
        heading == "Loan Tenure" || heading == "Time Period"
            ? Slider(
                value: sliderValue.toDouble(),
                min: min,
                max: max,
                onChanged: (double? value) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  action(value!, true, heading);
                })
            : Slider(
                value: sliderValue,
                min: min,
                max: max,
                divisions: divisions,
                onChanged: (double? value) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  action(value!, true, heading);
                })
      ],
    ));
  }
}
