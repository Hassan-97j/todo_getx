import 'package:flutter/material.dart';
//import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

const Color bluishClr = Color(0xff4e5ae8);
const Color yellowishClr = Color(0xffff8746);
const Color pinkClr = Color(0xffff4667);
const Color darkGrayClr = Color(0xff121212);
const Color darkHeaderClr = Color(0xff424242);
const Color primaryClr = bluishClr;
const Color whiteColor = Colors.white;

class Themes {
  static final lightMode = ThemeData(
    backgroundColor: whiteColor,
    primaryColor: primaryClr,
    brightness: Brightness.light,
  );

  static final darkMode = ThemeData(
    backgroundColor: darkGrayClr,
    primaryColor: darkGrayClr ,
    brightness: Brightness.dark,
  );
}

TextStyle get headingTextStyle{
  return GoogleFonts.lato(
      textStyle:  TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ), 
  );
}

TextStyle get subHeadingTextStyle{
  return GoogleFonts.lato(
      textStyle:  TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
      ),
  );
}

TextStyle get titleTextStyle{
  return GoogleFonts.lato(
      textStyle:  TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Get.isDarkMode ? Colors.white : Colors.black
      ),
  );
}

TextStyle get subTitleTextStyle{
  return GoogleFonts.lato(
      textStyle:  TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
      ),
  );
}