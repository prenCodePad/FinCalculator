import 'package:fincalculator/Widgets/investmentcalculator.dart';
import 'package:fincalculator/locator.dart';
import 'package:fincalculator/providers/investmentcalprovider.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvestmentScreen extends StatelessWidget {
  InvestmentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(decoration: theme.appbardecoration()),
          backgroundColor: theme.appBarColor,
          title: Text(
            "Investment Calculator",
            style: theme.display24w600(),
          ),
        ),
        backgroundColor: theme.white,
        body: SingleChildScrollView(
            child: ChangeNotifierProvider(
                create: (_) => InvestmentProvider(),
                child: InvestmentCalculator())));
  }
}
