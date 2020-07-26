import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/material.dart';
import 'package:guideTemplate/screens/next_screen.dart';
import 'package:guideTemplate/utils/ads_helper.dart';
import 'package:guideTemplate/utils/navigator.dart';
import 'package:guideTemplate/utils/strings.dart';
import 'package:guideTemplate/utils/theme.dart';
import 'package:guideTemplate/utils/tools.dart';
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
    ads.loadFbInter(AdsHelper.fbInterId_1);
    customDrawer = new CustomDrawer(() => ads.showInter());
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
            ads: ads.getFbNativeBanner(
                AdsHelper.fbNativeBannerId1, NativeBannerAdSize.HEIGHT_50),
            onClicked: () => ads.showInter(),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                MainButton(
                  title: Text(
                    'Articles',
                    style: MyTextStyles.bigTitle,
                  ),
                  svgIcon: 'assets/icons/articles.svg',
                  onClicked: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return NextScreen(
                        widget: MainButton(
                          title: Text(
                            'Go to articles',
                            style: MyTextStyles.bigTitle,
                          ),
                          bgColor: MyColors.grey1,
                          svgIcon: 'assets/icons/articles.svg',
                          onClicked: () {
                            MyNavigator.goArticles(context);
                          },
                        ),
                      );
                    }));
                  },
                ),
                MainButton(
                  title: Text(
                    'Our Store',
                    style: MyTextStyles.bigTitle,
                  ),
                  svgIcon: 'assets/icons/more_apps.svg',
                  onClicked: () {
                    Tools.launchURLMore();
                  },
                ),
                MainButton(
                  title: Text(
                    Strings.privacy,
                    style: MyTextStyles.bigTitle,
                  ),
                  svgIcon: 'assets/icons/privacy_policy.svg',
                  onClicked: () {
                    ads.showInter(probablity: 80);
                    MyNavigator.goPrivacy(context);
                  },
                ),
                MainButton(
                  title: Text(
                    'About',
                    style: MyTextStyles.bigTitle,
                  ),
                  svgIcon: 'assets/icons/about.svg',
                  onClicked: () async {
                    int count = await showDialog(
                        context: context, builder: (_) => RatingDialog());
                    String text = '';
                    if (count != null) {
                      if (count <= 2)
                        text = 'Your rating was $count ☹ alright, thank you.';
                      if (count == 3) text = 'Thanks for your rating 🙂';
                      if (count >= 4) text = 'Thanks for your rating 😀';
                      scaffoldKey.currentState.showSnackBar(
                        new SnackBar(
                          content: Text(text),
                        ),
                      );
                    }
                    if (count != null && count <= 3)
                      ads.showInter(probablity: 80);
                  },
                ),
                /*MainButton(
                  title: Text(
                    'Notifications',
                    style: MyTextStyles.bigTitle,
                  ),
                  svgIcon: 'assets/icons/notif.svg',
                  onClicked: () {
                    ads.showInter(probablity: 80);
                  },
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
