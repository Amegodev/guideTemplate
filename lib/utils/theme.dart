import 'package:flutter/material.dart';

class MyColors {
  static Color white = Color(0XFFFFFFFF);

  static Color grey1 = Color(0XFFF3F3F5);
  static Color grey2 = Color(0XFFDFE1E3);
  static Color grey3 = Color(0XFF65676A);

  static Color black = Color(0XFF050505);

  static Map<String, Color> darklight = {
    "dark": Color(0XFF171717),
    "light": Color(0XFFEBEBEB),
  };
}

class MyTextStyles {
  static TextStyle bigTitle = TextStyle(
      fontFamily: 'Montserrat',
      color: MyColors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold);
  static TextStyle title = TextStyle(
      fontFamily: 'Montserrat',
      color: MyColors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.bold);
  static TextStyle subTitle = TextStyle(
    fontFamily: 'Montserrat',
    color: MyColors.black,
    fontSize: 16.0,
  );
  static TextStyle fbTitleBigBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );
  static TextStyle fbTitleBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  static TextStyle fbTitle = TextStyle(
    fontSize: 16.0,
  );
  static TextStyle fbSubTitleBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
  static TextStyle fbText = TextStyle(
    fontSize: 14.0,
  );
}
