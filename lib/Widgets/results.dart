import 'package:fincalculator/locator.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Results extends StatelessWidget {
  final String label1;
  final double value1;
  final String label2;
  final double value2;
  final String label3;
  final double value3;
  Results({
    Key? key,
    required this.label1,
    required this.value1,
    required this.label2,
    required this.value2,
    required this.label3,
    required this.value3,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    var formatter = NumberFormat('#,##,##0');
    // print("value1 $value1");
    // print("value2 $value2");
    // print("value3 $value3");
    return Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        label1,
        style: theme.body4(),
      ),
      Text(
        "₹${formatter.format(value1.round())}",
        //"₹${formatter.format(value1.isNaN || value1.isInfinite ? 0 : value1 == 0 ? 0 : value1.toInt())}",
        style: theme.body2(),
      ),
      SizedBox(height: 15),
      Text(
        label2,
        style: theme.body4(),
      ),
      Text(
        "₹${formatter.format(value2.round())}",
        // "₹${formatter.format(value2.isNaN ? 0 : value2.toInt())}",
        style: theme.body2(),
      ),
      SizedBox(height: 15),
      Text(
        label3,
        style: theme.body4(),
      ),
      Text(
        "₹${formatter.format(value3.round())}",
        //  "₹${formatter.format(value3.isNaN ? value1.isNaN ? 0 : value1 : value3.toInt())}",
        style: theme.body2(),
      ),
      SizedBox(height: 15),
    ]));
  }
}
