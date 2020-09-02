import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:guideTemplate/articles.dart';
import 'package:guideTemplate/utils/ads_helper.dart';
import 'package:guideTemplate/utils/theme.dart';
import 'package:guideTemplate/utils/tools.dart';
import 'package:guideTemplate/widgets/drawer.dart';
import 'package:guideTemplate/widgets/widgets.dart';

class ArticleScreen extends StatefulWidget {
  final int index;

  const ArticleScreen({Key key, this.index}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  AdsHelper ads;
  CustomDrawer customDrawer;

  @override
  void initState() {
    super.initState();
    ads = new AdsHelper();
    ads.loadFbInter(AdsHelper.fbInterId_2);
    customDrawer = new CustomDrawer(() => ads.showInter(),scaffoldKey);
  }

  @override
  void dispose() {
    ads.disposeAllAds();
    super.dispose();
  }

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: customDrawer.buildDrawer(context),
      backgroundColor: MyColors.grey1,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CustomAppBar(
              scaffoldKey: scaffoldKey,
              title: Tools.packageInfo.appName,
              ads: ads.getFbNativeBanner(
                  AdsHelper.fbNativeBannerId_2, NativeBannerAdSize.HEIGHT_50),
              onClicked: () => ads.showInter(probablity: 90),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: HtmlWidget(
                    Articles.bodyes[widget.index],
                    textStyle: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ),
            MainButton(
              title: Text(
                'Return',
                style: MyTextStyles.bigTitle.apply(color: MyColors.white),
              ),
              svgIcon: 'assets/icons/back.svg',
              bgColor: MyColors.grey3,
              textColor: MyColors.white,
              onClicked: () {
                ads.showInter();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
