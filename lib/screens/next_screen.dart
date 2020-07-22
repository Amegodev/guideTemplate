import 'package:flutter/material.dart';
import 'package:guideTemplate/utils/ads_helper.dart';
import 'package:guideTemplate/utils/navigator.dart';
import 'package:guideTemplate/utils/theme.dart';
import 'package:guideTemplate/utils/tools.dart';
import 'package:guideTemplate/widgets/drawer.dart';
import 'package:guideTemplate/widgets/widgets.dart';

class NextScreen extends StatefulWidget {
  final Widget widget;

  const NextScreen({Key key, this.widget}) : super(key: key);

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
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
          ),
          widget.widget,
          MainButton(
            title: Text(
              'Home',
              style: MyTextStyles.bigTitle,
            ),
            svgIcon: 'assets/icons/home.svg',
            onClicked: () => MyNavigator.goHome(context),
          ),
          MainButton(
            title: Text(
              'Return',
              style: MyTextStyles.bigTitle.apply(color: MyColors.white),
            ),
            svgIcon: 'assets/icons/back.svg',
            bgColor: MyColors.grey3,
            textColor: MyColors.white,
            onClicked: () => Navigator.pop(context),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: MyColors.grey2,
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(color: Colors.blue, width: 1.5),
              ),
              child: Center(
                child: ads.getFbNative(AdsHelper.fbNativeId, double.infinity),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
