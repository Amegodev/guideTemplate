import 'package:flutter/material.dart';

class MyColors {
  static Color primary = Color(0XFF2F4377);
  static Color secondary = Color(0XFF3D5896);
  static Color third = Color(0XFFC2CCED);
  static Color blue = Color(0XFF1878F3);
  static Color greyDark1 = Color(0XFF5C5D61);
  static Color greyDark = Color(0XFF8A8D92);
  static Color greyLight = Color(0XFFF1F3F4);

  static Map<String, Color> darklight = {
    "dark": Color(0XFF171717),
    "light": Color(0XFFEBEBEB),
  };
}

class MyTextStyles {
  static TextStyle bigTitle = TextStyle(
      fontFamily: 'Montserrat',
      color: MyColors.third,
      fontSize: 20.0,
      fontWeight: FontWeight.bold);
  static TextStyle title = TextStyle(
      fontFamily: 'Montserrat',
      color: MyColors.third, fontSize: 18.0, fontWeight: FontWeight.bold);
  static TextStyle subTitle = TextStyle(
    fontFamily: 'Montserrat',
    color: MyColors.third,
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
