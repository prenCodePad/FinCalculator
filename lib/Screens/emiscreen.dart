import 'package:fincalculator/Widgets/emicalculator.dart';
import 'package:fincalculator/locator.dart';
import 'package:fincalculator/providers/emicalprovider.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            child: ChangeNotifierProvider(
                create: (_) => EMIProvider(), child: EMICalculator())));
  }
}
