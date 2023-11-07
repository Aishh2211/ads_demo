

import 'package:flutter/material.dart';

class InterstitialView extends StatelessWidget {
  const InterstitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Interstitial Demo"),),
      body: const Center(
        child: Text("Interstitial Ad displaying on Alternative clicks",style: TextStyle(fontWeight: FontWeight.bold),)
      ),
    );
  }
}
