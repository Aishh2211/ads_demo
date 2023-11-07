import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Screens/HomeScreen/home_view.dart';
import 'Screens/SplashScreen/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ///initialization of Admob in main.dart
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Signature Maker',
      themeMode: ThemeMode.system,
      initialRoute: '/',
      getPages:  [
        GetPage(name: '/', page: () => SplashView()),
        GetPage(name: '/home', page: () =>HomeView()),
      ],
    );
  }
}
