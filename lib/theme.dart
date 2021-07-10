import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FinAppTheme {
  Color appBarColor = const Color(0xff1F8BDE);
  Color screenBgc = const Color(0xffF3F5F6);
  Color white = const Color(0xffffffff);
  Color chipTextColor = const Color(0xff000000);
  Color border = Colors.grey[300]!;
  TextStyle display24() => GoogleFonts.lato(
      fontSize: 24, fontWeight: FontWeight.w800, color: chipTextColor);

  TextStyle display16() => GoogleFonts.lato(
      fontSize: 16, fontWeight: FontWeight.w400, color: chipTextColor);

  TextStyle display16w600() => GoogleFonts.lato(
      fontSize: 16, fontWeight: FontWeight.w600, color: chipTextColor);

  TextStyle display20w400() => GoogleFonts.lato(
      fontSize: 20, fontWeight: FontWeight.w400, color: chipTextColor);

  double get calculatorChipHeight => ScreenUtil().screenHeight * 0.27;
  double get quoteHeight => ScreenUtil().screenHeight * 0.25;
  double get noAppBarMargin => ScreenUtil().screenHeight * 0.03;
  double get sliderHeight => ScreenUtil().screenHeight * 0.1;
  double get fullheight => ScreenUtil().screenHeight;
  double get investmentScreenheight => ScreenUtil().screenHeight * 0.9;
  double get emiScreenHeight => ScreenUtil().screenHeight * 0.9;
  double get chartradius => ScreenUtil().screenWidth * 0.3;

  TextStyle body18w400() => GoogleFonts.lato(
      fontSize: 18, fontWeight: FontWeight.w800, color: chipTextColor);
  TextStyle body12w600() => GoogleFonts.lato(
      fontSize: 12, fontWeight: FontWeight.w600, color: chipTextColor);

  TextStyle body2() => GoogleFonts.lato(
      fontSize: 20, fontWeight: FontWeight.bold, color: chipTextColor);
  TextStyle body3() => GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w600, color: chipTextColor);
  TextStyle body4() => GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w200, color: chipTextColor);

  static BoxShadow _chipShadow = BoxShadow(
      color: Color.fromRGBO(42, 91, 128, 0.12),
      blurRadius: 20,
      offset: const Offset(0, 8));

  InputDecoration formTextDecoration(String label) => InputDecoration(
      contentPadding: new EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      labelText: label,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 0.1, style: BorderStyle.none)));

  Gradient _gradient(List<Color> colors) => LinearGradient(
      colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight);

  BoxDecoration calculatorDecoration() => BoxDecoration(
        boxShadow: [_chipShadow],
        // image: DecorationImage(
        //   colorFilter: ColorFilter.mode(
        //       Colors.white.withOpacity(0.5), BlendMode.dstATop),
        //   image: AssetImage("assets/images/investment2.jfif"),
        // ),
        color: white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: border),
      );

  BoxDecoration imageDecoration() => BoxDecoration(
        image: DecorationImage(
          // colorFilter: ColorFilter.mode(
          //     Colors.white.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage("assets/images/investment2.jfif"),
        ),
      );

  BoxDecoration appbardecoration() => BoxDecoration(
          gradient: _gradient([
        Color(0xff1F8BDE),
        Color(0xff0F9FD8),
      ]));

  TextStyle display24w600() => GoogleFonts.poppins(
      fontSize: 24, fontWeight: FontWeight.w600, color: white);
}
