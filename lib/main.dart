import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guideTemplate/screens/about_page.dart';
import 'package:guideTemplate/screens/articles_list.dart';
import 'package:guideTemplate/screens/counter_page.dart';
import 'package:guideTemplate/screens/fetching_page.dart';
import 'package:guideTemplate/screens/home.dart';
import 'package:guideTemplate/screens/privacy_policy.dart';
import 'package:guideTemplate/screens/servers_page.dart';
import 'package:guideTemplate/screens/slash_page.dart';
import 'package:guideTemplate/screens/try_again_page.dart';
import 'package:guideTemplate/utils/ads_helper.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/counter": (BuildContext context) => CounterPage(),
  "/servers": (BuildContext context) => ServersPage(),
  "/fetching": (BuildContext context) => FetchingPage(),
  "/try": (BuildContext context) => TryAgainPage(),
  "/privacy": (BuildContext context) => PrivacyScreen(),
  "/articles": (BuildContext context) => ArticlesScreen(),
  "/about": (BuildContext context) => AboutPage(),
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  AdsHelper.initFacebookAds();
  AdsHelper.initAdmobAds();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guide',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat'),
      routes: routes,
      home: SplashScreen(),
    );
  }
}
