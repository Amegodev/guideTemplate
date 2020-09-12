import 'package:flutter/material.dart';
import 'package:guideTemplate/screens/next_screen.dart';
import 'package:guideTemplate/utils/ads_helper.dart';
import 'package:guideTemplate/utils/navigator.dart';
import 'package:guideTemplate/utils/strings.dart';
import 'package:guideTemplate/utils/theme.dart';
import 'package:guideTemplate/utils/tools.dart';
import 'package:guideTemplate/widgets/dialogs.dart';
import 'package:guideTemplate/widgets/drawer.dart';
import 'package:guideTemplate/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreeState createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScreen> {
  AdsHelper ads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    ads = new AdsHelper();
    ads.load();
    customDrawer = new CustomDrawer(() => ads.showInter(), scaffoldKey);
  }

  @override
  void dispose() {
    ads.disposeAllAds();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: customDrawer.buildDrawer(context),
      body: Column(
        children: <Widget>[
          CustomAppBar(
            scaffoldKey: scaffoldKey,
            title: Tools.packageInfo.appName,
            ads: ads.getBanner(),
            onClicked: () => ads.showInter(),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                MainButton(
                  title: Text(
                    'Start',
                    style: MyTextStyles.bigTitle,
                  ),
                  bgColor: Color(0xFF74B3D2),
                  svgIcon: 'assets/icons/play.svg',
                  onClicked: () {
                    ads.showInter();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return NextScreen(
                        widget: MainButton(
                          title: Text(
                            'Next',
                            style: MyTextStyles.bigTitle,
                          ),
                          bgColor: Color(0xFF74B3D2),
                          svgIcon: 'assets/icons/play.svg',
                          onClicked: () {
                            ads.showInter();
                            MyNavigator.goCounter(context);
                          },
                        ),
                      );
                    }));
                  },
                ),
                MainButton(
                  title: Text(
                    'Walkthrough',
                    style: MyTextStyles.bigTitle,
                  ),
                  bgColor: Color(0xFF74955E),
                  svgIcon: 'assets/icons/articles.svg',
                  onClicked: () {
                    ads.showInter();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return NextScreen(
                        widget: MainButton(
                          title: Text(
                            'Next',
                            style: MyTextStyles.bigTitle,
                          ),
                          bgColor: Color(0xFF74B3D2),
                          svgIcon: 'assets/icons/articles.svg',
                          onClicked: () {
                            MyNavigator.goArticles(context);
                          },
                        ),
                      );
                    }));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: MainButton(
                    title: Text(
                      'More Apps',
                      style: MyTextStyles.bigTitle,
                    ),
                    svgIcon: 'assets/icons/more_apps.svg',
                    onClicked: () {
                      Tools.launchURLMore();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: MainButton(
                    title: Text(
                      Strings.privacy,
                      style: MyTextStyles.bigTitle,
                    ),
                    svgIcon: 'assets/icons/privacy_policy.svg',
                    onClicked: () {
                      ads.showInter();
                      MyNavigator.goPrivacy(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: MainButton(
                    title: Text(
                      'About',
                      style: MyTextStyles.bigTitle,
                    ),
                    svgIcon: 'assets/icons/about.svg',
                    onClicked: () async {
                      MyNavigator.goAbout(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
