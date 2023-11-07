import 'package:ads_demo/Screens/SplashScreen/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../Helper/Global_variables.dart';


class SplashView extends StatelessWidget {
  SplashView({super.key, });

  final SplashViewModel splashViewModel= Get.put(SplashViewModel());


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
            Padding(
              padding: const EdgeInsets.only(top:300),
              child: Column(
                children: [
                  const Center(
                      child: Text("Ads Demo",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
                  const Center(
                      child: Text("Splash Screen",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Obx(
                          () => splashViewModel.isLoading.value
                          ?  const CircularProgressIndicator(
                           color: Colors.blue,
                                strokeWidth: 4,
                                ): ElevatedButton(
                              onPressed: (){
                                //checking if interstitial add already loaded or not
                                if(!GlobalVariable.isInterAdShowing.value ) {
                                  //showing interstitial ad on button click & going to homeScreen
                                  splashViewModel.adsHelper.showInterstitialAd(isSplash: true);
                                }else{
                                  Get.offNamed('/home');
                                }
                              },
                              child: const Text("Let's Start",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                          ),
                    ),
                  ),

                ],
              ),
            ),


        ],
      ),
    );
  }


}
