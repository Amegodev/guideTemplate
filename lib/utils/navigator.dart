import 'package:flutter/material.dart';

class MyNavigator {
  static void goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }

  static void goArticles(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  static void goAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  static void goPrivacy(BuildContext context) {
    Navigator.pushNamed(context, '/privacy');
  }
}
