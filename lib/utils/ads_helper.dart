import 'dart:math';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:guideTemplate/utils/theme.dart';

class AdsHelper {
  static String testingId = '49561229-6006-416f-a4e5-8ff12965dd02';

  //===================================> Facebook Ads:
  //FB Banner
  static String fbBannerId_1 = '3128195607198965_3128266117191914';
  static String fbBannerId_2 = '3128195607198965_3131196756898850';

  //FB Inter
  static String fbInterId_1 = '3128195607198965_3130888846929641';
  static String fbInterId_2 = '3128195607198965_3131231876895338';

  //FB Native Banner
  static String fbNativeBannerId = '3128195607198965_3331361980215659';

  //FB Native
  static String fbNativeId = '3128195607198965_3331362690215588';

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
    } else{
      print("================(in show fb Inter)=========> Interstial Ad not yet loaded!");
    }
  }

  showInter({int probablity = 50, delay = 0}) async {
    Random r = new Random();
    double falseProbability = (100 - probablity) / 100;
    bool result = r.nextDouble() > falseProbability;
    if(result) {
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
          backgroundColor: MyColors.primary,
          titleColor: MyColors.darklight["dark"],
          descriptionColor: MyColors.darklight["dark"],
          buttonColor: MyColors.secondary,
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
          backgroundColor: MyColors.primary,
          titleColor: MyColors.darklight["dark"],
          descriptionColor: MyColors.darklight["dark"],
          buttonColor: MyColors.secondary,
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
