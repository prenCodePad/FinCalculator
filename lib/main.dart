import 'package:fincalculator/Screens/mainscreen.dart';
import 'package:fincalculator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: () => MaterialApp(
            title: 'FinCal',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MainScreen()));
  }
}
