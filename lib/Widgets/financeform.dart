import 'package:fincalculator/locator.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FinanceForm extends StatelessWidget {
  final String heading;
  final TextEditingController controller;
  final String? label;
  final Function? action;

  FinanceForm({
    Key? key,
    required this.heading,
    required this.controller,
    this.label,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 1, child: Text(heading, style: theme.display20w400())),
        SizedBox(width: 10),
        Expanded(
            flex: 1,
            child: Container(
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: theme.display20w400(),
                    textAlign: TextAlign.end,
                    controller: controller,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is Mandatory';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if (value != "")
                        action!(int.parse(value).toDouble(), false, heading);
                    },
                    decoration: theme.formTextDecoration(label!))))
      ],
    );
  }
}
