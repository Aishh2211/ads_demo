

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GlobalVariable {

  static RxBool isOpenAppAdShowing = false.obs;
  static RxBool isInterAdShowing = false.obs;

///In kDebugMode , testing ads will show,
  static String bannerAdAndroid =
  kDebugMode ? "ca-app-pub-3940256099942544/6300978111" : "REPLACE WITH REAL IDS";
  static String interstitialAdAndroid =
  kDebugMode ? "ca-app-pub-3940256099942544/1033173712" : "REPLACE WITH REAL IDS";
  static String nativeAdAndroid =
  kDebugMode ? "ca-app-pub-3940256099942544/2247696110" : "REPLACE WITH REAL IDS";
  static String appOpenAdAndroid =
  kDebugMode ? "ca-app-pub-3940256099942544/3419835294" : "REPLACE WITH REAL IDS";

  static String bannerAdIOS = kDebugMode ? "ca-app-pub-3940256099942544/2934735716"
      : "REPLACE WITH REAL IDS";
  static String interstitialAdIOS = kDebugMode ? "ca-app-pub-3940256099942544/4411468910"
      : "REPLACE WITH REAL IDS";
  static String nativeAdIOS = kDebugMode ? "ca-app-pub-3940256099942544/3986624511"
      : "REPLACE WITH REAL IDS";
  static String appOpenAdIOS = kDebugMode ? "ca-app-pub-3940256099942544/5662855259"
      : "REPLACE WITH REAL IDS";

}


//Add real App id for Android in : AndroidManifest.xml
//Add real App id for IOS in : Info.plist