import 'package:flutter/material.dart';
import 'package:guideTemplate/utils/navigator.dart';
import 'package:guideTemplate/utils/theme.dart';
import 'package:guideTemplate/utils/tools.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  initThenGoHomeScreen() {
    Future.wait([
      Tools.getAppInfo(),
      Tools.copyDataBase(),
      Tools.fetchData(),
      Future.delayed(
          Duration(seconds: 10),
          () => print(
              "===( Future )============= delayed ======================> : Just delayed"))
    ]).then((value) => MyNavigator.goHome(context));
    /* Future.delayed(Duration(seconds: 5), () async {
      
    }); */
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    controller.repeat(reverse: true);
    initThenGoHomeScreen();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Tools.getDeviceDimention(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: MyColors.grey1,
        ),
        child: Center(
          child: ScaleTransition(
            scale: Tween(begin: 1.0, end: 1.2).animate(
                CurvedAnimation(parent: controller, curve: Curves.ease)),
            child: Image.asset(
              'assets/icon.png',
              width: 100.0,
            ),
          ),
        ),
      ),
    );
  }
}
