import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guideTemplate/screens/home.dart';
import 'package:guideTemplate/screens/privacy_policy.dart';
import 'package:guideTemplate/utils/ads_helper.dart';
import 'package:guideTemplate/utils/tools.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/privacy": (BuildContext context) => Privacy(),
  "/articles": (BuildContext context) => Privacy(),
};

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  AdsHelper.initFacebookAds();
  Tools.getAppInfo().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guide',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat'),
      routes: routes,
      home: HomeScreen(),
    );
  }
}
