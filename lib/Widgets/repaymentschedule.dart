import 'package:fincalculator/locator.dart';
import 'package:fincalculator/providers/emicalprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class RepaymentSchedule extends StatelessWidget {
  RepaymentSchedule({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    List<String> statementColumns = [
      "Date",
      "Principal",
      "Interest",
      "Payment",
      "Outstanding",
    ];
    var formatter = NumberFormat('#,##,##0');

    _textForreport(String text) {
      return Expanded(flex: 1, child: Text(text, style: theme.display16w600()));
    }

    final emiProvider = Provider.of<EMIProvider>(context, listen: true);
    var emiSchedule = emiProvider.rapaymentSchedule;
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Container(
          height: theme.fullheight * 0.08,
          padding: EdgeInsets.all(theme.screenWidth * 0.015),
          child: ToggleSwitch(
            activeBgColor: [
              const Color(0xff1F8BDE),
              const Color(0xff0F9FD8),
            ],
            inactiveBgColor: const Color(0xffF3F5F6),
            activeFgColor: const Color(0xffF3F5F6),
            //animate: true,
            initialLabelIndex: emiProvider.isReportForyear ? 1 : 0,
            totalSwitches: 2,
            labels: ['Month', 'Year'],
            onToggle: (index) {
              emiProvider.setisReportforMonth();
            },
          )),
      Container(
          padding: EdgeInsets.fromLTRB(
              theme.screenWidth * 0.02,
              theme.screenWidth * 0.025,
              theme.screenWidth * 0.02,
              theme.screenWidth * 0.025),
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
          child: Scrollbar(
              radius: Radius.circular(10),
              thickness: 5,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: emiSchedule.length,
                  itemBuilder: (_, ind) => Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.1)),
                      ),
                      padding: EdgeInsets.all(theme.screenWidth * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _textForreport(
                              "${!emiProvider.isReportForyear ? DateFormat("yMMM").format(emiSchedule[ind].installmentDate!) : DateFormat("y").format(emiSchedule[ind].installmentDate!)}"),
                          _textForreport(
                              "₹${formatter.format(emiSchedule[ind].principal.round())}"),
                          _textForreport(
                              "₹${formatter.format(emiSchedule[ind].interest.round())}"),
                          _textForreport(
                              "₹${formatter.format(emiProvider.emi)}"),
                          _textForreport(
                              "₹${formatter.format(emiSchedule[ind].outstandingBalance.round())}")
                        ],
                      )))))
    ]);
  }
}
