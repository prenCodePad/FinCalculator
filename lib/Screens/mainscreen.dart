import 'package:fincalculator/Widgets/availablecalculators.dart';
import 'package:fincalculator/locator.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    return Scaffold(
      backgroundColor: theme.screenBgc,
      appBar: AppBar(
        flexibleSpace: Container(decoration: theme.appbardecoration()),
        backgroundColor: theme.appBarColor,
        title: Text(
          "Financial Calculators",
          style: theme.display24w600(),
        ),
      ),
      body: SingleChildScrollView(
        child: AvailableCalculators(),
      ),
    );
  }
}
