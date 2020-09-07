import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:guideTemplate/utils/ads_helper.dart';
import 'package:guideTemplate/utils/strings.dart';
import 'package:guideTemplate/utils/theme.dart';
import 'package:guideTemplate/widgets/drawer.dart';
import 'package:guideTemplate/widgets/widgets.dart';

class PrivacyScreen extends StatefulWidget {
  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  AdsHelper ads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    ads = new AdsHelper();
    ads.load();
    customDrawer = new CustomDrawer(() => ads.showInter(),scaffoldKey);
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
      backgroundColor: MyColors.grey1,
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -200.0,
            top: -50.0,
            child: Opacity(
              child: SvgPicture.asset(
                'assets/icons/privacy_policy.svg',
                width: 500.0,
              ),
              opacity: 0.2,
            ),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                CustomAppBar(
                  scaffoldKey: scaffoldKey,
                  title: Strings.privacy,
                  ads: ads.getBanner(),
                  onClicked: () => ads.showInter(probability: 90),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: HtmlWidget(
                        Strings.privacyText,
                        textStyle: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                MainButton(
                  title: Text(
                    'Return',
                    style: MyTextStyles.bigTitle
                        .apply(color: MyColors.white),
                  ),
                  svgIcon: 'assets/icons/back.svg',
                  bgColor: MyColors.grey3,
                  textColor: MyColors.white,
                  onClicked: () {
                    ads.showInter(probability: 80);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
