import 'dart:math';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:facebook_audience_network/ad/ad_banner.dart' as banner;
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:guideTemplate/utils/theme.dart';
import 'package:guideTemplate/utils/tools.dart';
import 'package:startapp/startapp.dart';

class AdsHelper {
  final admobNativeController = NativeAdmobController();

//===================================> Facebook Ads:
  //FB Banner
  static String fbBannerId_1 = '';
  static String fbBannerId_2 = '';

  //FB Inter
  static String fbInterId_1 = '';
  static String fbInterId_2 = '';

  //FB Native Banner
  static String fbNativeBannerId_1 = '';
  static String fbNativeBannerId_2 = '';

  //FB Native
  static String fbNativeId_1 = '';
  static String fbNativeId_2 = '';

//===================================> Admob Ads:
  //Admob Banner
  static String admobBannerId_1 =
      'ca-app-pub-9868138867214816/3208988867'; // test : ca-app-pub-3940256099942544/6300978111
//  static String admobBannerId_1 = 'ca-app-pub-3940256099942544/6300978111'; // test : ca-app-pub-3940256099942544/6300978111
  static String admobBannerId_2 = 'ca-app-pub-9868138867214816/6042024000';
//  static String admobBannerId_2 = 'ca-app-pub-3940256099942544/6300978111';

  //Admob Inter
  static String admobInterId_1 =
      'ca-app-pub-9868138867214816/7164545746'; // test : ca-app-pub-3940256099942544/1033173712
//  static String admobInterId_1 = 'ca-app-pub-3940256099942544/1033173712'; // test : ca-app-pub-3940256099942544/1033173712
  static String admobInterId_2 = 'ca-app-pub-9868138867214816/1550091131';
//  static String admobInterId_2 = 'ca-app-pub-3940256099942544/1033173712';

  //Admob Native
  static String admobNativeId_1 =
      'ca-app-pub-9868138867214816/9237009461'; // test : ca-app-pub-3940256099942544/2247696110
//  static String admobNativeId_1 = 'ca-app-pub-3940256099942544/2247696110'; // test : ca-app-pub-3940256099942544/2247696110
  static String admobNativeId_2 = 'ca-app-pub-9868138867214816/7923927795';
//  static String admobNativeId_2 = 'ca-app-pub-3940256099942544/2247696110';

  //Admob Reward
  static String admobRewardId_1 =
      ''; // test : ca-app-pub-3940256099942544/5224354917
  static String admobRewardId_2 =
      ''; // test : ca-app-pub-3940256099942544/5224354917

  int loadInterAttempts = 0;

  Widget fbBannerAd, admobBannerAd, startAppBannerAd; //Banners
  Widget fbNativeBannerAd, fbNativeAd, admobNativeAd; //Natives
  //Interstitials
  FacebookInterstitialAd fbInterAd;
  AdmobInterstitial admobInterAd;

  //Rewards
  AdmobReward rewardAd;

  static int adsFrequency = 20;
  bool isFbInterAdLoaded = false;
  bool isAdmobInterAdLoaded = false;
  bool isAdmobRewardedloaded = false;
  bool isAdmobRewarded = false;
  Function(bool) onRewarded;

//=======================================  Device ID For Testing :

//  static String testingId = '49561229-6006-416f-a4e5-8ff12965dd02'; //  AVD

  static String testingId =
      '3f14f4ef-8bfb-4c82-abae-75b16dfa2559'; //  My Real Device

  //// Admob App Id
  static String appId = 'ca-app-pub-7200723121807417~8921314692';

//======================================= Initialize Ads :
  static void initFacebookAds() {
    FacebookAudienceNetwork.init(
      testingId: AdsHelper.testingId,
    );
  }

  static void initAdmobAds() {
    Admob.initialize(testDeviceIds: [AdsHelper.testingId]);
  }

  loadFbInter(String fbInterId) {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: fbInterId,
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED) {
          isFbInterAdLoaded = true;
        }
        if (result == InterstitialAdResult.ERROR) {
          showAdmobInter();
          print('===> Showing Admob Instead');
        }
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          isFbInterAdLoaded = false;
          loadFbInter(fbInterId);
        }
        print("===(Fb Inter)===> result : $result =====> value : $value");
      },
    );
  }

  loadAdmobInter(String admobInterId) {
    admobInterAd = AdmobInterstitial(
      adUnitId: admobInterId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed || event == AdmobAdEvent.completed)
          admobInterAd.load();
        if (event == AdmobAdEvent.loaded) isAdmobInterAdLoaded = true;
        if (event == AdmobAdEvent.failedToLoad) {
          isAdmobInterAdLoaded = false;
          loadInterAttempts++;
          if (loadInterAttempts <= 2) {
            loadAdmobInter(admobInterId);
            print(
                '=================> $loadInterAttempts attempts to load admob inter');
          }
        }
        print("===(Admob Inter)===> result : $event =====> args : $args");
      },
    );
    admobInterAd.load();
  }

  load() {
    Random r = new Random();
    bool id = r.nextBool();
//    print("===(bannerAdType)===> $bannerAdType");
    if (Tools.config.admob["active"] == 'true') {
      String admobInterId = id
          ? Tools.config.admob["inter1"]
          : Tools.config.admob["inter2"];
      loadAdmobInter(admobInterId);
    } else
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxx Admob Ads inactive");
    if (Tools.config.fb["active"] == 'true') {
      String fbInterId = id
          ? Tools.config.fb["inter1"]
          : Tools.config.fb["inter2"];
      loadFbInter(fbInterId);
    } else
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxx Fb Ads inactive");
  }

  loadAdmobReward(String admobRewardId) {
    rewardAd = AdmobReward(
      adUnitId: admobRewardId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) {
          onRewarded(isAdmobRewarded);
          rewardAd.load();
          isAdmobRewarded = false;
        }
        if (event == AdmobAdEvent.loaded) isAdmobRewardedloaded = true;
        if (event == AdmobAdEvent.rewarded) isAdmobRewarded = true;
        if (event == AdmobAdEvent.failedToLoad) {
          isAdmobRewardedloaded = false;
          isAdmobRewarded = false;
          loadAdmobReward(admobRewardId);
        }
        print("===(Admob Reward)===> result : $event =====> args : $args");
      },
    );
    rewardAd.load();
  }

  showFbInter(int delay) {
    if (isFbInterAdLoaded == true) {
      FacebookInterstitialAd.showInterstitialAd(delay: delay);
      print('===(Fb Inter)===> Inter Ad is about to be Showen :D');
    } else {
      print("===(fb Inter)===> Inter Ad not yet loaded!");
    }
  }

  showAdmobInter({delay = 0}) {
    if (isAdmobInterAdLoaded == true) {
      Future.delayed(Duration(milliseconds: delay), () => admobInterAd.show());
      print('===(Admob Inter)===> Inter Ad is about to be Showen :D');
    } else {
      print("===(Admob Inter)===> Inter Ad not yet loaded!");
    }
  }

  showAdmobReward({Function(bool) onFailedLoad}) {
    if (isAdmobRewardedloaded == true) {
      rewardAd.show();
      print('===(Admob Reward)===> Reward Ad is about to be Showen :D');
    } else {
      onFailedLoad(isAdmobInterAdLoaded);
      print("===(Admob Reward)===> Reward Ad not yet loaded!");
    }
  }

  showStartAppInter({delay = 0}) async {
    Future.delayed(Duration(milliseconds: delay), () async {
      await StartApp.showInterstitialAd();
    });
    print('===(StartApp Inter)===> Inter Ad is about to be Showen :D');
  }

  showInter({int probability, delay = 0}) async {
    if (probability == null) probability = AdsHelper.adsFrequency;
    Random r = new Random();
    double falseProbability = (100 - probability) / 100;
    bool result = r.nextDouble() > falseProbability;
    if (isFbInterAdLoaded || isAdmobInterAdLoaded) {
      if (result) {
        if (Tools.config.admob["active"] == 'true') {
          isAdmobInterAdLoaded
              ? showAdmobInter(delay: delay)
              : showStartAppInter();
        } else if (Tools.config.fb["active"] == 'true') {
          isFbInterAdLoaded ? showFbInter(delay) : showStartAppInter();
        } else {
          showStartAppInter();
        }
      }
      print(
          '===> Probablity of $probability% return ( $result ) with AdNetwork : ( ${Tools.config} )');
    } else {
      showStartAppInter();
      print('===> No AdNetwork Inter Loaded Showing startapp Instead');
    }
  }

  Widget getFbBanner(String bannerId, banner.BannerSize size) {
    if (fbBannerAd == null) {
      fbBannerAd = Container(
        //margin: EdgeInsets.only(bottom: 5.0),
        alignment: Alignment(0.5, 1),
        child: FacebookBannerAd(
          placementId: bannerId,
          bannerSize: size,
          listener: (result, value) {
            print("===(Fb Banner)===> $value");
          },
        ),
      );
    }
    return fbBannerAd;
  }

  Widget getFbNativeBanner(String nativeBannerId, NativeBannerAdSize size) {
    if (fbNativeBannerAd == null) {
      fbNativeBannerAd = Container(
        child: FacebookNativeAd(
          placementId: nativeBannerId,
          adType: NativeAdType.NATIVE_BANNER_AD,
          bannerAdSize: size,
          width: double.infinity,
          backgroundColor: MyColors.white.withOpacity(0.8),
          titleColor: MyColors.black,
          descriptionColor: Colors.grey,
          buttonColor: Colors.black,
          buttonTitleColor: Colors.white,
          buttonBorderColor: Colors.black,
          listener: (result, value) {
            print("===(Fb NativeBanner)===> $value");
            if(result == NativeAdResult.ERROR){
              return null;
            }
          },
        ),
      );
    }
    return fbNativeBannerAd;
  }

  Widget getFbNative(String fbNativeId, double width, double height) {
    if (fbNativeAd == null) {
      fbNativeAd = FacebookNativeAd(
        placementId: fbNativeId,
        adType: NativeAdType.NATIVE_AD,
        width: width,
        height: height,
        backgroundColor: MyColors.grey2,
        titleColor: Colors.black,
        descriptionColor: Colors.black,
        buttonColor: MyColors.black,
        buttonTitleColor: Colors.white,
        buttonBorderColor: Colors.white,
        listener: (result, value) {
          print("================(Fb Native)==============> : --> $value");
        },
      );
    }
    return fbNativeAd;
  }

  Widget getAdmobBanner(String bannerId, AdmobBannerSize size) {
    if (admobBannerAd == null) {
      admobBannerAd = Container(
        child: AdmobBanner(
          adUnitId: bannerId,
          adSize: size,
          listener: (AdmobAdEvent event, Map<String, dynamic> args) {
            print("===(Admob Banner)===> result : $event =====> $args");
            if (event == AdmobAdEvent.failedToLoad) {
              return null;
            }
          },
        ),
      );
    }
    return admobBannerAd;
  }

  Widget getAdmobNative(String admobNativeId, double width, double height) {
    admobNativeController.setTestDeviceIds([AdsHelper.testingId]);
//    _controller.setNonPersonalizedAds(true);
    if (admobNativeAd == null) {
      admobNativeAd = Container(
        height: height,
        width: width,
        child: NativeAdmob(
          adUnitID: admobNativeId,
          loading: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircularProgressIndicator(),
              ),
              Text(
                "Loading Ad...",
                style: TextStyle(color: MyColors.black.withOpacity(0.3)),
              )
            ],
          )),
          error: Center(
              child: Text(
            "Ad",
            style: MyTextStyles.bigTitle
                .apply(color: MyColors.black.withOpacity(0.3)),
          )),
          controller: admobNativeController,
          type: NativeAdmobType.full,
          options: NativeAdmobOptions(
            ratingColor: Colors.red,
            // Others ...
          ),
        ),
      );
    }
    return admobNativeAd;
  }

  Widget getStartAppBanner() {
    if (startAppBannerAd == null) {
      startAppBannerAd = AdBanner();
    }
    return startAppBannerAd;
  }

  Widget getBanner() {
    Random r = new Random();
    bool id = r.nextBool();
//    print("===(bannerAdType)===> $bannerAdType");
    if (Tools.config.admob["active"] == 'true') {
      String admobBannerId = id
          ? Tools.config.admob["banner1"]
          : Tools.config.admob["banner2"];
      return getAdmobBanner(admobBannerId, AdmobBannerSize.BANNER) ??
          getStartAppBanner();
    } else if (Tools.config.fb["active"] == 'true') {
      String fbBannerId = id
          ? Tools.config.fb["nativebanner1"]
          : Tools.config.fb["nativebanner2"];
      return getFbNativeBanner(fbBannerId, NativeBannerAdSize.HEIGHT_50) ??
          getStartAppBanner();
    } else {
      return getStartAppBanner();
    }
  }

  Widget getNative(double height, double width) {
    Random r = new Random();
    bool id = r.nextBool();
//    print("===(bannerAdType)===> $bannerAdType");
    if (Tools.config.admob["active"] == 'true') {
      String admobNativeId = id
          ? Tools.config.admob["native1"]
          : Tools.config.admob["native2"];
      return getAdmobNative(admobNativeId, height, width) ??
          getStartAppBanner();
    } else if (Tools.config.fb["active"] == 'true') {
      String fbNativeId = id
          ? Tools.config.fb["native1"]
          : Tools.config.fb["native2"];
      return getFbNative(fbNativeId, height, width) ?? getStartAppBanner();
    } else {
      return getStartAppBanner();
    }
  }

  Widget getNativeBanner() {
    Random r = new Random();
    bool id = r.nextBool();
//    print("===(bannerAdType)===> $bannerAdType");
    if (Tools.config.admob["active"] == 'true') {
      String admobNativeBannerId = id
          ? Tools.config.admob["native1"]
          : Tools.config.admob["native2"];
      return getAdmobNative(admobNativeBannerId, 50.0, double.infinity) ??
          getStartAppBanner();
    } else if (Tools.config.fb["active"] == 'true') {
      String fbBannerId = id
          ? Tools.config.fb["nativebanner1"]
          : Tools.config.fb["nativebanner2"];
      return getFbNativeBanner(fbBannerId, NativeBannerAdSize.HEIGHT_50) ??
          getStartAppBanner();
    } else {
      return getStartAppBanner();
    }
  }

  disposeAllAds() {
    if (Tools.config.admob["active"] == 'true') {
      admobInterAd.dispose();
    }
    if (Tools.config.fb["active"] == 'true') {
      FacebookInterstitialAd.destroyInterstitialAd();
    }
  }
}
