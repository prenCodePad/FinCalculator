import 'package:fincalculator/locator.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FinanceForm extends StatelessWidget {
  final String heading;
  final TextEditingController controller;
  final String? label;
  final Function? action;
  final double? max;
  final double? min;

  FinanceForm(
      {Key? key,
      required this.heading,
      required this.controller,
      this.label,
      this.action,
      this.max,
      this.min})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 1, child: Text(heading, style: theme.display20w400())),
        SizedBox(width: theme.screenWidth * 0.02),
        Expanded(
            flex: 1,
            child: Container(
              height: theme.fullheight * 0.055,
              child: heading == "Interest Rate" || heading == "Est Return Rate"
                  ? CustomTextBox(
                      controller: controller,
                      formatters: [],
                      action: action!,
                      heading: heading,
                      max: max!,
                      label: label!)
                  : CustomTextBox(
                      controller: controller,
                      formatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                      ],
                      action: action!,
                      heading: heading,
                      max: max!,
                      label: label!),
            ))
      ],
    );
  }
}

class CustomTextBox extends StatelessWidget {
  final TextEditingController controller;
  final List<TextInputFormatter> formatters;
  final Function action;
  final String heading;
  final double max;
  final String label;

  CustomTextBox({
    Key? key,
    required this.controller,
    required this.formatters,
    required this.action,
    required this.heading,
    required this.max,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    SnackBar snackBar(String message) {
      return SnackBar(
        duration: Duration(seconds: 2),
        content: Text(message),
      );
    }

    return TextFormField(
        inputFormatters: formatters,
        keyboardType: TextInputType.number,
        style: theme.display20w400(),
        textAlign: TextAlign.end,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        onChanged: (value) {
          if (value.isEmpty || value == "") {
            action(0.0, false, heading);
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar("Blank is considered as 0"));
          } else if (double.parse(value) > max) {
            FocusManager.instance.primaryFocus?.unfocus();
            controller.text = max.round().toString();
            action(max, false, heading);
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar("Exceeded maximum value"));
          } else if (value == ".") {
          } else {
            action(double.parse(value), false, heading);
          }
        },
        decoration: theme.formTextDecoration(label));
  }
}
