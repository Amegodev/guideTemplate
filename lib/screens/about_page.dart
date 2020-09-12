import 'package:flutter/material.dart';
import 'package:guideTemplate/utils/ads_helper.dart';
import 'package:guideTemplate/utils/strings.dart';
import 'package:guideTemplate/utils/theme.dart';
import 'package:guideTemplate/utils/tools.dart';
import 'package:guideTemplate/widgets/drawer.dart';
import 'package:guideTemplate/widgets/widgets.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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

  int _stars = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: customDrawer.buildDrawer(context),
      body: Column(
        children: [
          CustomAppBar(
            scaffoldKey: scaffoldKey,
            leading: IconButton(
              icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
              onPressed: () {
                ads.showInter();
                Navigator.pop(context);
              },
            ),
            title: "About",
            ads: ads.getBanner(),
            onClicked: () => ads.showInter(),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    height: 80,
                    width: 80,
                    child: Image.asset('assets/icon.png'),
                  ),
                ),
                Text(
                  Tools.packageInfo.appName,
                  style: MyTextStyles.bigTitle.apply(color: MyColors.black),
                ),
                Text(
                  'version ' + Tools.packageInfo.version,
                  style: MyTextStyles.subTitle,
                ),
                SizedBox(
                  height: 100.0,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Strings.ratingText,
                      textAlign: TextAlign.center,
                      style: MyTextStyles.subTitle,
                    ),
                    Text(
                      '👇 Please Rate App 👇',
                      textAlign: TextAlign.center,
                      style: MyTextStyles.subTitle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildStar(1),
                        _buildStar(2),
                        _buildStar(3),
                        _buildStar(4),
                        _buildStar(5),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        _stars >= starCount ? Icons.star : Icons.star_border,
        size: 30.0,
        color: _stars >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () {
        print(starCount);
        if (starCount >= 4) {
          Navigator.pop(context);
          Tools.launchURLRate();
        }
        setState(() {
          _stars = starCount;
        });
      },
    );
  }
}
