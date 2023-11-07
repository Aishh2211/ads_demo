
import 'package:ads_demo/helper/ads_helper.dart';
import 'package:get/get.dart';



class SplashViewModel extends GetxController {
  //creating object of AdsHelper to use its method and load ad
  AdsHelper adsHelper =AdsHelper();
  RxBool isLoading = true.obs;

  @override
  void onReady() {
    //load interstitial ad to display on button click in splash screen
    adsHelper.loadInterstitialAd();
    //for delay of 5 seconds before displaying button in splash screen
    Future.delayed(const Duration(seconds: 5), () {
      isLoading.value = false;
    });
    super.onReady();
  }

}
