
import 'package:ads_demo/helper/ads_helper.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class HomeViewModel extends GetxController{
  final AdsHelper homeAdsHelper =AdsHelper();  //// An instance of AdsHelper for managing and loading ads

  @override
  void onReady() {
    //load all ads use in this screen
    homeAdsHelper.loadInterstitialAd();
    homeAdsHelper.loadBannerAd();
    homeAdsHelper.loadNativeAd();
    homeAdsHelper.loadOpenAppAd();
    listenToAppStateChanges(); //An instance of AdsHelper for managing ads
    super.onReady();
  }

  //for checking app state changes
  void listenToAppStateChanges(){
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) => onAppStateChanged(state));
  }

  // calling openAppAd when app go on background state
  void onAppStateChanged(AppState appState){
    if(appState == AppState.foreground){
      if(homeAdsHelper.appOpenAd != null  )  {
        print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@Open App Ad should show@@@@@@@@@@@@@@@@@@@@@@');
        homeAdsHelper.openAppAdCallBack();
        homeAdsHelper.appOpenAd!.show();
      } else if (homeAdsHelper.appOpenAd == null){
        homeAdsHelper.loadOpenAppAd();
      }
    }
  }


}