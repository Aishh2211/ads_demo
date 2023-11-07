import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'Global_variables.dart';


class AdsHelper  {
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  RxBool isBannerAdReady = false.obs;
  NativeAd? nativeAd;
  bool isInterstitialAdLoaded = false;
  RxBool nativeAdIsLoaded = false.obs;
  bool showInterstitial = true;
  AppOpenAd? appOpenAd;
  bool isShowingAd = false;
  static bool isLoaded = false;
  int lastInterstitialTabIndex = 0;
  bool isInterstitialLoading = false; //*

  String bannerAdUnitId = Platform.isAndroid
      ? GlobalVariable.bannerAdAndroid
      : GlobalVariable.bannerAdIOS;
  String interstitialAdUnitId = Platform.isAndroid
      ? GlobalVariable.interstitialAdAndroid
      : GlobalVariable.interstitialAdIOS;
  String nativeAdUnitId = Platform.isAndroid
      ? GlobalVariable.nativeAdAndroid
      : GlobalVariable.nativeAdIOS;
  String appOpenAdUnitId = Platform.isAndroid
      ? GlobalVariable.appOpenAdAndroid
      : GlobalVariable.appOpenAdIOS;

  ///loading openAppAd
  void loadOpenAppAd() {
    AppOpenAd.load(
      adUnitId: appOpenAdUnitId,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          if (kDebugMode) {
            print("Ad Loaded.................................");
          }
          appOpenAd = ad;
          isLoaded = true;
        },
        onAdFailedToLoad: (error) {
          // Handle the error.
        },
      ),
    );
  }

  /// Callback for app open ad events
  openAppAdCallBack() {
    appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        GlobalVariable.isOpenAppAdShowing.value = true;
        print('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        GlobalVariable.isOpenAppAdShowing.value = false;
        appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        GlobalVariable.isOpenAppAdShowing.value = false;
        appOpenAd = null;
        loadOpenAppAd();
      },
    );
  }

  /// Method to load banner ad
  Future<void> loadBannerAd() async {
    final AnchoredAdaptiveBannerAdSize? size =
    await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(Get.context!).size.width.truncate());
    bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      request: const AdRequest(),
      size: size!,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          isBannerAdReady.value = true;
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  ///  Method to load interstitial ad
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          isInterstitialAdLoaded = true;
        },
        onAdFailedToLoad: (error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  /// Method to show interstitial ad with an optional splash screen
  void showInterstitialAd({bool isSplash=false}){
    if (showInterstitial) {
      if(isInterstitialAdLoaded){
        interstitialAdCallBack(isSplash: isSplash);
        interstitialAd!.show();
      }else{
        if(isSplash){
          Get.offNamed('/home');
        }
        loadInterstitialAd();
      }
    }
    showInterstitial = !showInterstitial;
  }

 /// Callback for interstitial ad events
  void interstitialAdCallBack({required bool isSplash}){
    interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        GlobalVariable.isInterAdShowing.value = true;
        print('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        GlobalVariable.isInterAdShowing.value = false;
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        GlobalVariable.isInterAdShowing.value = false;
        isInterstitialAdLoaded = false;
        interstitialAd?.dispose();
        interstitialAd = null;
        if(!isSplash) {
          loadInterstitialAd();
        }else{
          Get.offNamed('/home');
        }
      },
    );
  }

  /// Method to load and show native ad
  void loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId:nativeAdUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            debugPrint('$NativeAd loaded.');
            nativeAdIsLoaded.value = true;
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            debugPrint('$NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
            templateType: TemplateType.medium,
            mainBackgroundColor: Colors.white,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.white,
                backgroundColor: Colors.blue,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
  }

}


