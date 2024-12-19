import 'dart:async';

import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () => context.replace('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              "assets/logos/logo.png",
              height: 96,
              width: 96,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 64,
              child: LinearProgressIndicator(
                color: AppColors().primaryColor,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
