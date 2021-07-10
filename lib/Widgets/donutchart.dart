import 'package:fincalculator/locator.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DonutRepresentation extends StatelessWidget {
  final Map<String, double> dataMap;
  DonutRepresentation({Key? key, required this.dataMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorList = [Colors.blueAccent, Colors.greenAccent];
    var theme = locator<FinAppTheme>();

    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 2000),
      chartLegendSpacing: 32,
      chartRadius: theme.chartradius,
      colorList: colorList,
      initialAngleInDegree: 270,
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      centerText: "",
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: false,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }
}
