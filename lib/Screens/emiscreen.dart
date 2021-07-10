import 'package:fincalculator/Widgets/investmentcalculator.dart';
import 'package:fincalculator/locator.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';

class EMIScreen extends StatelessWidget {
  EMIScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(decoration: theme.appbardecoration()),
          backgroundColor: theme.appBarColor,
          title: Text(
            "EMI Calculator",
            style: theme.display24w600(),
          ),
        ),
        backgroundColor: theme.white,
        body: SingleChildScrollView(
            child: Center(
          child: Text("Coming Soon.."),
        )));
  }
}
