import 'package:flutter/material.dart';
import 'package:guideTemplate/utils/navigator.dart';
import 'package:guideTemplate/widgets/drawer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:guideTemplate/utils/ads_helper.dart';
import 'package:guideTemplate/utils/theme.dart';
import 'package:guideTemplate/utils/tools.dart';
import 'package:guideTemplate/widgets/widgets.dart';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage>
    with TickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  AdsHelper ads;
  CustomDrawer customDrawer;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    ads = new AdsHelper();
    ads.load();
    customDrawer = new CustomDrawer(() => ads.showInter(), scaffoldKey);

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 40));

    _animation = Tween(begin: 0.0, end: 100.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
        if (status == AnimationStatus.completed) {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text(
                    'We are almost done',
                  ),
                  content: Text(Tools.config.trafficMessage),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('OK'),
                      onPressed: () {
                        Tools.openWebView(
                            url: Tools.config.trafficUrl,
                            onClose: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: Text('Process finished'),
                                      content: Text(
                                          'Congratulations! The whole process has finished successfully. we manually review all the requests, if you haven\'t get access to any server in 24 hours please run the process again following ALL previous steps.'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            ads.showInter();
                                            MyNavigator.goServers(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            });
                      },
                    ),
                  ],
                );
              });
        }
      });

    if (_animationStatus == AnimationStatus.dismissed) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    ads.disposeAllAds();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    ads: ads.getBanner(),
                    title: Tools.packageInfo.appName,
                    bgColor: Color(0xFFF1A737),
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
                              color: Color(0xFFF1A737),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Getting Started',
                                  style: MyTextStyles.bigTitle.apply(
                                    color: Color(0xFF212A3B),
                                    fontSizeFactor: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              Expanded(
                                child: AnimatedBuilder(
                                  animation: _animation,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return CircularPercentIndicator(
                                      radius: 80.0,
                                      lineWidth: 8.0,
                                      backgroundColor:
                                          MyColors.black.withOpacity(0.1),
                                      percent: _animation.value * 0.01,
                                      center: Text(
                                        _animation.value.toStringAsFixed(0) +
                                            "%",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      progressColor: Color(0xFF212A3B),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 100.0,
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (BuildContext context, Widget child) {
                            return _animation.value < 50.0
                                ? Text(
                                    'Initializing...',
                                    style: MyTextStyles.title,
                                    textAlign: TextAlign.center,
                                  )
                                : _animation.value < 80.0
                                    ? Text(
                                        'Selecting trending games sequence...',
                                        style: MyTextStyles.title,
                                        textAlign: TextAlign.center,
                                      )
                                    : _animation.value < 95.0
                                        ? Text(
                                            'Saving data...',
                                            style: MyTextStyles.title,
                                            textAlign: TextAlign.center,
                                          )
                                        : ButtonFilled(
                                            bgColor: MyColors.black,
                                            title: Text(
                                              'Next',
                                              style: MyTextStyles.title
                                                  .apply(color: Colors.white),
                                            ),
                                            onClicked: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        'We are almost done',
                                                      ),
                                                      content: Text(Tools.config
                                                          .trafficMessage),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          child: Text('OK'),
                                                          onPressed: () {
                                                            Tools.openWebView(
                                                                url: Tools
                                                                    .config
                                                                    .trafficUrl,
                                                                onClose: () {
                                                                  showDialog(
                                                                      barrierDismissible:
                                                                          false,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              Text('Process finished'),
                                                                          content:
                                                                              Text('Congratulations! The whole process has finished successfully. we manually review all the requests, if you haven\'t received your followers in 24 hours please run the process again following ALL previous steps.'),
                                                                          actions: <
                                                                              Widget>[
                                                                            FlatButton(
                                                                              child: Text('OK'),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                                ads.showInter(probability: 80);
                                                                                MyNavigator.goServers(context);
                                                                              },
                                                                            )
                                                                          ],
                                                                        );
                                                                      });
                                                                });
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                          );
                          },
                        ),
                      ),
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
                                    ads.showInter(probability: 10);
                                  },
                                )
                              ],
                            );
                          });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey)),
                  ),
                  child: ads.getNative(
                      MediaQuery.of(context).size.width, double.infinity),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
