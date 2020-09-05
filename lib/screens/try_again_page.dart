import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guideTemplate/utils/strings.dart';
import 'package:guideTemplate/widgets/drawer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:guideTemplate/utils/ads_helper.dart';
import 'package:guideTemplate/utils/navigator.dart';
import 'package:guideTemplate/utils/theme.dart';
import 'package:guideTemplate/utils/tools.dart';
import 'package:guideTemplate/widgets/widgets.dart';
import 'package:timer_count_down/timer_count_down.dart';

class TryAgainPage extends StatefulWidget {
  @override
  _TryAgainPageState createState() => _TryAgainPageState();
}

class _TryAgainPageState extends State<TryAgainPage> {
  AdsHelper ads;
  CustomDrawer customDrawer;
  int totalPoints;
  String username;
  List servers;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    ads = new AdsHelper();
    ads.loadFbInter(AdsHelper.fbInterId_2);
    customDrawer = new CustomDrawer(() => ads.showInter(), scaffoldKey);
    servers = Tools.shuffle(Strings.servers, 5, 15);
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  @override
  void dispose() {
    ads.disposeAllAds();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    if (args != null) {
      totalPoints = int.parse(args['totalPoints']);
      username = args['username'];
    }

    return Scaffold(
      key: scaffoldKey,
      drawer: customDrawer.buildDrawer(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    CustomAppBar(
                      scaffoldKey: scaffoldKey,
                      title: Tools.packageInfo.appName,
                      bgColor: Colors.redAccent,
                      ads: ads.getFbNativeBanner(
                          AdsHelper.fbNativeBannerId_2, NativeBannerAdSize.HEIGHT_50),
                      onClicked: () => ads.showInter(probability: 90),
                    ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Positioned(
                          top: -MediaQuery.of(context).size.width,
                          child: Container(
                            height: MediaQuery.of(context).size.width * 1.5,
                            width: MediaQuery.of(context).size.width * 1.5,
                            decoration: BoxDecoration(
                              color: Color(0xFF212A3B),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          top: -MediaQuery.of(context).size.width,
                          child: Container(
                            height: MediaQuery.of(context).size.width * 1.485,
                            width: MediaQuery.of(context).size.width * 1.485,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Server is corrupted at the moment\n try again in ',
                                  style: MyTextStyles.title.apply(
                                    color: MyColors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Countdown(
                                        seconds: 86400,
                                        build: (BuildContext context,
                                            double time) {
                                          return Text(
                                            format(
                                              Duration(seconds: time.toInt()),
                                            ),
                                            style:
                                            MyTextStyles.bigTitle.apply(
                                              color: MyColors.black,
                                              fontSizeFactor: 1.5,
                                            ),
                                            textAlign: TextAlign.center,
                                          );
                                        },
                                        interval: Duration(milliseconds: 100),
                                        onFinished: () {
                                          MyNavigator.goHome(context);
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: LinearPercentIndicator(
                                          width: 140.0,
                                          lineHeight: 5.0,
                                          percent: 1,
                                          animationDuration: 60 * 1000,
                                          animation: true,
                                          alignment: MainAxisAlignment.center,
                                          restartAnimation: true,
                                          backgroundColor: Colors.black12,
                                          progressColor: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom:20.0),
                                child: Center(child: SvgPicture.asset('assets/icons/error.svg', height: 50.0,)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ButtonOutlined(
                      title: Text(
                        'View Active servers',
                        style:
                        MyTextStyles.title.apply(color: MyColors.black),
                      ),
                      onClicked: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text('Last active Servers \nTry one of them', textAlign: TextAlign.center,),
                                content: Text(servers.toList().join(' \n')),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(' I understand'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      ads.showInter();
                                    },
                                  )
                                ],
                              );
                            });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      "Or you can try again with a different server",
                      style: new TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ButtonFilled(
                      title: Text(
                        'TRY AGAIN',
                        style: MyTextStyles.title.apply(color: Colors.white),
                      ),
                      onClicked: () {
                        ads.showInter();
                        Navigator.of(context).popUntil(
                            ModalRoute.withName("/servers"));
//                            ModalRoute.withName("/fetching"));
                      },
                    ),
                  ),
                  InkWell(
                    child: Text(
                      "Not working?",
                      style: new TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text('Not working ?'),
                              content: Text(
                                  'If you have not received anything within 24 hours, please re-launch the process after a few days. The Server blocks us every so often due to the high number of requests.\nThanks for your understanding.'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    ads.showInter(probability: 20);
                                  },
                                )
                              ],
                            );
                          });
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.0,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey)),
                  ),
                  child: ads.getFbNative(AdsHelper.fbNativeId_2,
                      MediaQuery.of(context).size.width,double.infinity ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
