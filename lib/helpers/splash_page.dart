import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paycoin/pages/home_page.dart';

import '../services/texts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Get.offAll(() => const HomePage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Paycoin', style: playlistStyle)],
        ),
      ),
    );
  }
}
