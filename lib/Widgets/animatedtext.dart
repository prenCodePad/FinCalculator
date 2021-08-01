import 'package:carousel_slider/carousel_slider.dart';
import 'package:fincalculator/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    var items = [
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: theme.fullheight * 0.01),
        Text('"Investing is Simple\nBut not easy"', style: theme.body18w400()),
        SizedBox(height: theme.fullheight * 0.02),
        Text("-Warren Buffet", style: theme.body12w600()),
      ]),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: theme.fullheight * 0.01),
        Text(
            '"Beware of little expenses,\na small leak will sink\na great ship"',
            style: theme.body18w400AN()),
        SizedBox(height: theme.fullheight * 0.02),
        Text("-Benjamin Franklin", style: theme.body12w600()),
      ]),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: theme.fullheight * 0.01),
        Text('"Hope is not a\na Financial Plan"', style: theme.body18w400()),
        SizedBox(height: theme.fullheight * 0.02),
        Text("-Ric Edelman", style: theme.body12w600()),
      ]),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: theme.fullheight * 0.01),
        Text(
            '"Every finanical \ndecision should be\ndriven by what you\n value"',
            style: theme.body18w400AN()),
        SizedBox(height: theme.fullheight * 0.02),
        Text("-Benjamin Franklin", style: theme.body12w600()),
      ]),
    ];
    return CarouselSlider(
        items: items,
        options: CarouselOptions(
            autoPlay: true, autoPlayAnimationDuration: Duration(seconds: 2)));
  }
}

  // Container(
  //         height: theme.quoteHeight,
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           color: Colors.lightBlueAccent[100],
  //           shape: BoxShape.circle,
  //         ),
  //         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
  //           SizedBox(height: theme.fullheight * 0.01),
  //           Text('''"Investing is Simple 
  //           But not easy"''', style: theme.body18w400()),
  //           SizedBox(height: theme.fullheight * 0.02),
  //           Text("-Warren Buffet", style: theme.body12w600()),
  //         ])),