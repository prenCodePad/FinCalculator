import 'package:fincalculator/Models/scheduledemi.dart';
import 'package:fincalculator/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RepaymentSchedule extends StatelessWidget {
  final List<ScheduledEMI> emiSchedule;
  RepaymentSchedule({Key? key, required this.emiSchedule}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    List<String> statementColumns = [
      "Date",
      "Interest",
      "Principal",
      "Outstanding"
    ];
    var formatter = NumberFormat('#,##,##0');
    return Column(children: [
      Container(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1)),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: statementColumns
                  .map((e) => Text(e, style: theme.display14w1000()))
                  .toList())),
      Container(
          height: theme.reportHeight,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: emiSchedule.length,
              itemBuilder: (_, ind) => Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.1)),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                              "${DateFormat("yMMM").format(emiSchedule[ind].installmentDate!)}",
                              style: theme.display16w600())),
                      Expanded(
                          flex: 1,
                          child: Text(
                              "₹${formatter.format(emiSchedule[ind].interest!.toInt())}",
                              style: theme.display16w600())),
                      Expanded(
                          flex: 1,
                          child: Text(
                              "₹${formatter.format(emiSchedule[ind].principal!.toInt())}",
                              style: theme.display16w600())),
                      Expanded(
                          flex: 1,
                          child: Text(
                              "₹${formatter.format(emiSchedule[ind].outstandingBalance!.toInt())}",
                              style: theme.display16w600()))
                    ],
                  ))))
    ]);
  }
}
