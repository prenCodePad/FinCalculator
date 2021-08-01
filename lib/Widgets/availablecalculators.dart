import 'package:fincalculator/Screens/emiscreen.dart';
import 'package:fincalculator/Screens/investmentscreen.dart';
import 'package:fincalculator/Widgets/animatedtext.dart';
import 'package:fincalculator/Widgets/calculatordefinition.dart';
import 'package:fincalculator/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';

class AvailableCalculators extends StatelessWidget {
  AvailableCalculators({Key? key}) : super(key: key);
  final Map<String, Map<String, String>> decidedCalculators = {
    "Investment Calculator": {
      "content":
          "Calculate the future value of your investments for both SIP (Systematic investment plan) and lumpsum amount.",
      "image": "assets/images/investment4.png"
    },
    "EMI Calculator": {
      "content":
          "Estimate monthly, quarterly and yearly installments on expected payable interest rates and total amount",
      "image": "assets/images/emi.png"
    }
  };

  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();

    return Column(children: [
      SizedBox(height: theme.fullheight * 0.02),
      Container(
          height: theme.quoteHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent[100],
            shape: BoxShape.circle,
          ),
          child: AnimatedText()),
      SizedBox(height: theme.fullheight * 0.01),
      ListView(
        shrinkWrap: true,
        children: [
          ...decidedCalculators.keys
              .map((e) => Calculator(
                  imageheight: theme.fullheight * 0.12,
                  heading: e,
                  content: decidedCalculators[e]!["content"]!,
                  imagePath: decidedCalculators[e]!["image"]!,
                  navigatedScreen: e == "Investment Calculator"
                      ? InvestmentScreen()
                      : EMIScreen()))
              .toList()
        ],
      )
    ]);
  }
}
