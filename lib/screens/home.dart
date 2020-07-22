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
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    ads = new AdsHelper();
    ads.loadFbInter(AdsHelper.fbInterId_1);
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
      drawer: CustomDrawer.buildDrawer(context),
      body: Column(
        children: <Widget>[
          CustomAppBar(
            scaffoldKey: scaffoldKey,
            title: Tools.packageInfo.appName,
            ads: ads.getFbNativeBanner(
                AdsHelper.fbNativeBannerId, NativeBannerAdSize.HEIGHT_50),
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
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
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
                    MyNavigator.goPrivacy(context);
                  },
                ),
                MainButton(
                  title: Text(
                    'Notifications',
                    style: MyTextStyles.bigTitle,
                  ),
                  svgIcon: 'assets/icons/notif.svg',
                  onClicked: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
