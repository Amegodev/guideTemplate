import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guideTemplate/articles.dart';
import 'package:guideTemplate/screens/article_details.dart';
import 'package:guideTemplate/utils/ads_helper.dart';
import 'package:guideTemplate/utils/theme.dart';
import 'package:guideTemplate/utils/tools.dart';
import 'package:guideTemplate/widgets/drawer.dart';
import 'package:guideTemplate/widgets/widgets.dart';

class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
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
            child: ListView.builder(
              itemCount: Articles.titles.length + 1,
              itemBuilder: (context, index) {
                return index != Articles.titles.length
                    ? MainButton(
                        title: Text(
                          Articles.titles[index],
                          style: MyTextStyles.bigTitle,
                        ),
                        svgIcon: 'assets/icons/articles.svg',
                        onClicked: () {
                          ads.showInter(probablity: 80);
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return ArticleScreen(
                              index: index,
                            );
                          }));
                        },
                      )
                    : MainButton(
                        title: Text(
                          'Return',
                          style: MyTextStyles.bigTitle
                              .apply(color: MyColors.white),
                        ),
                        svgIcon: 'assets/icons/back.svg',
                        bgColor: MyColors.grey3,
                        textColor: MyColors.white,
                        onClicked: () {
                          ads.showInter(probablity: 80);
                          Navigator.pop(context);
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
