import 'package:fincalculator/locator.dart';
import 'package:fincalculator/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calculator extends StatelessWidget {
  final String heading;
  final String content;
  final String imagePath;
  final Widget? navigatedScreen;
  final double imageheight;

  Calculator(
      {Key? key,
      required this.heading,
      required this.content,
      required this.imagePath,
      this.navigatedScreen,
      this.imageheight = 80})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = locator<FinAppTheme>();
    var color = theme.chipTextColor;
    var divider = Divider(
      color: color,
      height: 10,
      thickness: 0.5,
    );
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return navigatedScreen!;
          }));
        },
        child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            height: theme.calculatorChipHeight,
            decoration: theme.calculatorDecoration(true),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                heading,
                style: theme.display24(),
              ),
              divider,
              SizedBox(
                height: 20,
              ),
              Row(children: [
                Expanded(
                    flex: 3,
                    child: Text(
                      content,
                      softWrap: true,
                      textAlign: TextAlign.justify,
                      style: theme.display16(),
                    )),
                Expanded(
                    flex: 2,
                    child: Image(
                      height: imageheight,
                      image: AssetImage(imagePath),
                    ))
              ]),
            ]))
        //),
        );
  }
}
