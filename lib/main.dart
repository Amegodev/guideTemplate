import 'package:flutter/material.dart';
import 'package:guideTemplate/screens/home.dart';
import 'package:guideTemplate/utils/ads_helper.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen()
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AdsHelper.initFacebookAds();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guide',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
      home: HomeScreen(),
    );
  }
}
