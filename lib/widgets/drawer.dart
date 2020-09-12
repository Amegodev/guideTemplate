import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guideTemplate/utils/navigator.dart';
import 'package:guideTemplate/utils/strings.dart';
import 'package:guideTemplate/utils/theme.dart';
import 'package:guideTemplate/utils/tools.dart';
import 'package:guideTemplate/widgets/dialogs.dart';

class CustomDrawer {
  final VoidCallback onClicked;
  final GlobalKey<ScaffoldState> scaffoldKey;

  CustomDrawer(this.onClicked, this.scaffoldKey);

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: MyColors.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          'assets/icon.png',
                          width: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Tools.packageInfo == null
                        ? SizedBox()
                        : Padding(
                      padding:
                      const EdgeInsets.only(bottom: 20.0, top: 20.0),
                      child: Text(
                        Tools.packageInfo.appName,
                        style: MyTextStyles.bigTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 8.0, bottom: 8.0, right: 8.0),
                      child: FlatButton(
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100.0),
                        ),
                        onPressed: () {
                          this.onClicked();
                          MyNavigator.goHome(context);
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            SvgPicture.asset(
                              'assets/icons/home.svg',
                              width: 30.0,
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Text(
                              Strings.home,
                              style: MyTextStyles.title,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, bottom: 8.0, right: 8.0),
                      child: FlatButton(
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100.0),
                        ),
                        onPressed: () {
                          Tools.launchURLRate();
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            SvgPicture.asset(
                              'assets/icons/rate.svg',
                              width: 30.0,
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Text(
                              Strings.rate,
                              style: MyTextStyles.title,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, bottom: 8.0, right: 8.0),
                      child: FlatButton(
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100.0),
                        ),
                        onPressed: () {
                          Tools.launchURLMore();
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            SvgPicture.asset(
                              'assets/icons/more_apps.svg',
                              width: 30.0,
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Text(
                              Strings.more,
                              style: MyTextStyles.title,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, bottom: 8.0, right: 8.0),
                      child: FlatButton(
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          this.onClicked();
                          MyNavigator.goPrivacy(context);
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            SvgPicture.asset(
                              'assets/icons/privacy_policy.svg',
                              width: 30.0,
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Text(
                              Strings.privacy,
                              style: MyTextStyles.title,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, bottom: 8.0, right: 8.0),
                      child: FlatButton(
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100.0),
                        ),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (_) => RatingDialog()).then((value) {
                            if (value == null){
                              if (onClicked != null) this.onClicked();
                              return;
                            }
                            String text = '';
                            if (value <= 3) {
                              if (onClicked != null) this.onClicked();
                              if (value <= 2)
                                text = 'Your rating was $value ☹ alright, thank you.';
                              if (value == 3) text = 'Thanks for your rating 🙂';
                            } else if (value >= 4)
                              text = 'Thanks for your rating 😀';
                            scaffoldKey.currentState.showSnackBar(
                              new SnackBar(
                                content: Text(text),
                              ),
                            );
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            SvgPicture.asset(
                              'assets/icons/about.svg',
                              width: 30.0,
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Text(
                              Strings.about,
                              style: MyTextStyles.title,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Version ' + Tools.packageInfo.version,
                  style: MyTextStyles.subTitle.apply(fontSizeFactor: 0.8),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Build number ' + Tools.packageInfo.buildNumber,
                  style: MyTextStyles.subTitle.apply(fontSizeFactor: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
