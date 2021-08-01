import 'package:fincalculator/Widgets/donutchart.dart';
import 'package:fincalculator/Widgets/results.dart';
import 'package:fincalculator/Widgets/sliderinput.dart';
import 'package:fincalculator/locator.dart';
import 'package:fincalculator/providers/investmentcalprovider.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvestmentCalculator extends StatelessWidget {
  InvestmentCalculator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    final investmentProvider =
        Provider.of<InvestmentProvider>(context, listen: true);
    var investmentVariables = investmentProvider.investmentVariables;
    return Container(
        height: theme.investmentScreenheight,
        padding: EdgeInsets.fromLTRB(
            theme.screenWidth * 0.02, 0, theme.screenWidth * 0.02, 0),
        child: Column(children: [
          Expanded(flex: 1, child: InvestmentType()),
          SizedBox(height: theme.screenWidth * 0.025),
          Expanded(
              flex: 5,
              child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: investmentVariables.keys
                          .map((e) => Container(
                              height: theme.fullheight * 0.145,
                              child: SliderInput(
                                action: investmentProvider.setValue,
                                heading: e,
                                label: investmentVariables[e]!.representation,
                                controller: investmentVariables[e]!.controller!,
                                divisions: investmentVariables[e]!.divisions!,
                                max: investmentVariables[e]!.max!,
                                min: investmentVariables[e]!.min!,
                                sliderValue: investmentProvider.sliderValue(e),
                              )))
                          .toList()))),
          Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: DonutRepresentation(
                        dataMap: investmentProvider.dataMap,
                      )),
                  Expanded(
                      flex: 1,
                      child: Results(
                        label1: "Invested Value",
                        value1: investmentProvider.finalInvestedAmount,
                        label2: "Est. Returns",
                        value2: investmentProvider.finalReturns,
                        label3: "Total Value",
                        value3: investmentProvider.finalTotalAmount,
                      ))
                ],
              ))
        ]));
  }
}

class InvestmentType extends StatelessWidget {
  InvestmentType({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    final investmentProvider =
        Provider.of<InvestmentProvider>(context, listen: true);
    final radioValue = investmentProvider.typeOfInvestment;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: investmentProvider.typesOfInvestment
            .map((e) => Row(children: [
                  Radio<String>(
                      value: e,
                      groupValue: radioValue,
                      onChanged: (String? value) {
                        investmentProvider.setTypesOfInvestment(value);
                      }),
                  Text(e, style: theme.display16w600()),
                  if (e == "SIP") SizedBox(width: theme.screenWidth * 0.045)
                ]))
            .toList());
  }
}
