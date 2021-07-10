import 'package:fincalculator/locator.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Results extends StatelessWidget {
  final double investedValue;
  final double estimatedReturns;
  final double totalValue;
  Results(
      {Key? key,
      required this.investedValue,
      required this.estimatedReturns,
      required this.totalValue})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    var formatter = NumberFormat('#,##,000');
    return Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Invested Value",
        style: theme.body4(),
      ),
      Text(
        "₹${formatter.format(investedValue.toInt())}",
        style: theme.body2(),
      ),
      SizedBox(height: 10),
      Text(
        "Est. Returns",
        style: theme.body4(),
      ),
      Text(
        "₹${formatter.format(estimatedReturns.toInt())}",
        style: theme.body2(),
      ),
      SizedBox(height: 10),
      Text(
        "Total Value",
        style: theme.body4(),
      ),
      Text(
        "₹${formatter.format(totalValue.toInt())}",
        style: theme.body2(),
      ),
    ]));
  }
}
