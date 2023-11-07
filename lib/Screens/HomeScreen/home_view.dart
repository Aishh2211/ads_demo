

import 'package:ads_demo/Helper/Global_variables.dart';
import 'package:ads_demo/Screens/HomeScreen/Interstitial_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeViewModel homeViewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ads Demo Screen"),),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top:10,bottom: 10),
              child: Text("Displaying banner Ad",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
            ),
            showAdaptiveBannerAd(),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(top:10,bottom: 10),
              child: Text("Displaying Native Ad",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
            ),
            showNativeAdd(),
            const Divider(),
            const Text(
              "Click button to display Interstitial Ad",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: (){
              //showing interstitial ad on alternative click (one time showing , one time not showing)
              if(!GlobalVariable.isInterAdShowing.value ) {
                //showing interstitial ad on button click
               homeViewModel.homeAdsHelper.showInterstitialAd();
               Get.to(()=>const InterstitialView());
              }
            }, child:const Text("Interstitial Ad")),
          const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top:10,bottom: 20),
              child: Text("OpenApp AD showing when app return from background state",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }

  Widget showAdaptiveBannerAd() {
    return Obx(
            () => (homeViewModel.homeAdsHelper.isBannerAdReady.value  && !GlobalVariable.isOpenAppAdShowing.value  )
            ? Container(
          color: Colors.white,
          width: homeViewModel.homeAdsHelper.bannerAd!.size.width.toDouble(),
          height:
          homeViewModel.homeAdsHelper.bannerAd!.size.height.toDouble(),
          child: AdWidget(
            ad: homeViewModel.homeAdsHelper.bannerAd!,
          ),
        )
            : const SizedBox()
    );
  }
  Widget showNativeAdd(){
  return  Obx(()=>
     homeViewModel.homeAdsHelper.nativeAdIsLoaded.value ?
    ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 320, // minimum recommended width
        minHeight: 250, // minimum recommended height
        maxWidth: 400,
        maxHeight: 400,
      ),
      child: AdWidget(ad: homeViewModel.homeAdsHelper.nativeAd!),
    ) : const SizedBox(),
  );
  }
}
