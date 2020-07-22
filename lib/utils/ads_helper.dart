import 'dart:math';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:guideTemplate/utils/theme.dart';

class AdsHelper {
//  My Raal Device
//  static String testingId = '49561229-6006-416f-a4e5-8ff12965dd02';

  //AVD
  static String testingId = 'ea693ea7-9881-48ff-8bd2-ec06afb03136';

  //===================================> Facebook Ads:
  //FB Banner
  static String fbBannerId_1 = '2964537240339084_2964556847003790';
  static String fbBannerId_2 = '2964537240339084_2964646123661529';

  //FB Inter
  static String fbInterId_1 = '2964537240339084_2964646746994800';
  static String fbInterId_2 = '2964537240339084_2964647196994755';

  //FB Native Banner
  static String fbNativeBannerId = '2964537240339084_2964649440327864';

  //FB Native
  static String fbNativeId = '2964537240339084_2964651180327690';

  static int adsFrequency = 50;
  bool _isInterstitialAdLoaded = false;

  Widget fbBannerAd;
  Widget fbNativeBannerAd;
  Widget fbNativeAd;
  FacebookInterstitialAd fbInter;

  static void initFacebookAds() {
    FacebookAudienceNetwork.init(
      testingId: AdsHelper.testingId,
    );
  }

  loadFbInter(String fbInterId) {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: fbInterId,
      listener: (result, value) {
        print(
            "================(Fb Inter)===============> result : $result *********** =====> value : $value");
        if (result == InterstitialAdResult.LOADED) {
          _isInterstitialAdLoaded = true;
        }
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          loadFbInter(fbInterId);
        }
      },
    );
  }

  showFbInter(int delay) {
    if (_isInterstitialAdLoaded == true) {
      FacebookInterstitialAd.showInterstitialAd(delay: delay);
      print('===========(Fb Inter Showen)===========> :D');
    } else {
      print(
          "================(in show fb Inter)=========> Interstial Ad not yet loaded!");
    }
  }

  showInter({int probablity = 50, delay = 0}) async {
    Random r = new Random();
    double falseProbability = (100 - probablity) / 100;
    bool result = r.nextDouble() > falseProbability;
    if (result) {
      showFbInter(delay);
    }
    print('====================> Probablity of $probablity% return $result');
  }

  Widget getFbBanner(String bannerId, BannerSize size) {
    if (fbBannerAd == null) {
      fbBannerAd = Container(
        //margin: EdgeInsets.only(bottom: 5.0),
        alignment: Alignment(0.5, 1),
        child: FacebookBannerAd(
          placementId: bannerId,
          bannerSize: size,
          listener: (result, value) {
            print("================(Fb Banner)==============> $value");
          },
        ),
      );
    }
    return fbBannerAd;
  }

  Widget getFbNativeBanner(String nativeBannerId, NativeBannerAdSize size) {
    if (fbNativeBannerAd == null) {
      fbNativeBannerAd = Container(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: FacebookNativeAd(
          placementId: nativeBannerId,
          adType: NativeAdType.NATIVE_BANNER_AD,
          bannerAdSize: size,
          width: double.infinity,
          backgroundColor: MyColors.grey2.withOpacity(0.8),
          titleColor: MyColors.black,
          descriptionColor: MyColors.black,
          buttonColor: MyColors.black,
          buttonTitleColor: Colors.white,
          buttonBorderColor: Colors.white,
          listener: (result, value) {
            print("================(Fb NativeBanner)==============> $value");
          },
        ),
      );
    }
    return fbNativeBannerAd;
  }

  Widget getFbNative(String fbNativeId, double size) {
    if (fbNativeAd == null) {
      fbNativeAd = Container(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: FacebookNativeAd(
          placementId: fbNativeId,
          adType: NativeAdType.NATIVE_AD,
          width: double.infinity,
          height: size,
          backgroundColor: MyColors.grey2,
          titleColor: Colors.black,
          descriptionColor: Colors.black,
          buttonColor: MyColors.black,
          buttonTitleColor: Colors.white,
          buttonBorderColor: Colors.white,
          listener: (result, value) {
            print("================(Fb Native)==============> : --> $value");
          },
        ),
      );
    }
    return fbNativeAd;
  }

  disposeAllAds() {
    FacebookInterstitialAd.destroyInterstitialAd();
  }
}
