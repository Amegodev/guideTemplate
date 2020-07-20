import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guideTemplate/utils/ads_helper.dart';
import 'package:guideTemplate/utils/strings.dart';
import 'package:guideTemplate/utils/theme.dart';
import 'package:guideTemplate/utils/tools.dart';
import 'package:guideTemplate/widgets/drawer.dart';
import 'package:guideTemplate/widgets/widgets.dart';

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  AdsHelper ads;

  @override
  void initState() {
    super.initState();
    ads = new AdsHelper();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer.buildDrawer(context),
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
                  ads: ads.getFbNativeBanner(
                      AdsHelper.fbNativeBannerId, NativeBannerAdSize.HEIGHT_50),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Html(
                      data: Strings.privacyTaxt,
                      onLinkTap: (url) {
                        print("Opening $url");
                      },
                    ),
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
