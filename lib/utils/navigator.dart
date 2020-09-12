import 'package:flutter/material.dart';

class MyNavigator {
  static void goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }

  static void goCounter(BuildContext context) {
    Navigator.pushNamed(context, "/counter");
  }

  static void goServers(BuildContext context) {
    Navigator.pushNamed(context, "/servers");
  }

  static void goFetching(BuildContext context) {
    Navigator.pushNamed(context, "/fetching");
  }

  static void goTryAgain(BuildContext context) {
    Navigator.pushNamed(context, "/try");
  }

  static void goArticles(BuildContext context) {
    Navigator.pushNamed(context, '/articles');
  }

  static void goAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  static void goPrivacy(BuildContext context) {
    Navigator.pushNamed(context, '/privacy');
  }
}
