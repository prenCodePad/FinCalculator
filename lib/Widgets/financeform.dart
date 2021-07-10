import 'package:fincalculator/locator.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FinanceForm extends StatelessWidget {
  final String heading;
  final TextEditingController controller;
  final String? label;
  final Function? action;
  final int? max;
  final int? min;

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
    SnackBar snackBar(String message) {
      return SnackBar(
        content: Text(message),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 1, child: Text(heading, style: theme.display20w400())),
        SizedBox(width: 10),
        Expanded(
            flex: 1,
            child: Container(
                child: TextFormField(
                    inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                ],
                    keyboardType: TextInputType.number,
                    style: theme.display20w400(),
                    textAlign: TextAlign.end,
                    textAlignVertical: TextAlignVertical.center,
                    controller: controller,
                    onChanged: (value) {
                      if (value.isEmpty || value == "") {
                        action!(0, false, heading);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar("Blank is considered as 0"));
                      } else if (int.parse(value) > max!) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.text = max.toString();
                        action!(max, false, heading);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar("Exceeded maximum value"));
                      } else {
                        action!(int.parse(value), false, heading);
                      }
                    },
                    decoration: theme.formTextDecoration(label!))))
      ],
    );
  }
}
