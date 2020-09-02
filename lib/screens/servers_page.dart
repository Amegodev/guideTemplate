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

class ServersPage extends StatefulWidget {
  @override
  _ServersPageState createState() => _ServersPageState();
}

class _ServersPageState extends State<ServersPage> {
  AdsHelper ads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    ads = new AdsHelper();
    ads.loadFbInter(AdsHelper.fbInterId_1);
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
        children: [
          CustomAppBar(
            scaffoldKey: scaffoldKey,
            title: Tools.packageInfo.appName,
            ads: ads.getFbNativeBanner(
                AdsHelper.fbNativeBannerId_1, NativeBannerAdSize.HEIGHT_50),
            onClicked: () => ads.showInter(probablity: 90),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Strings.servers.length,
              itemBuilder: (ctx, index) {
                return index % 6 == 0 && index != 0
                    ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300.0,
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 1.5),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.0),
                            child: ads.getFbNative(
                              AdsHelper.fbNativeId,
                              MediaQuery.of(context).size.width,
                              double.infinity),
                        ),
                      )
                    : MainButton(
                        title: Text(
                          Strings.servers[index],
                          style: MyTextStyles.bigTitle,
                        ),
                        svgIcon: 'assets/icons/articles.svg',
                        onClicked: () {
                          ads.showInter();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return NextScreen(
                                  widget: MainButton(
                                    title: Text(
                                      'Playing on ' +
                                          Strings.servers[index]
                                              .split(' ')
                                              .last +
                                          ' Server',
                                      style: MyTextStyles.bigTitle,
                                    ),
                                    bgColor: MyColors.grey1,
                                    svgIcon: 'assets/icons/play.svg',
                                    onClicked: () {
                                      MyNavigator.goFetching(context);
                                    },
                                  ),
                                );
                              },
                            ),
                          );
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
