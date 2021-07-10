import 'package:fincalculator/Widgets/financeform.dart';
import 'package:flutter/material.dart';

class SliderInput extends StatelessWidget {
  final String heading;
  final String? label;
  final int sliderValue;
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
            max: max.toInt(),
            min: min.toInt()),
        heading == "Monthly Investment" ||
                heading == "Total Investment" ||
                heading == "Loan Amount"
            ? Slider(
                value: sliderValue.toDouble(),
                min: min,
                max: max,
                divisions: divisions,
                onChanged: (double? value) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  action(value!.toInt(), true, heading);
                })
            : Slider(
                value: sliderValue.toDouble(),
                min: min,
                max: max,
                onChanged: (double? value) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  action(value!.toInt(), true, heading);
                })
      ],
    ));
  }
}
