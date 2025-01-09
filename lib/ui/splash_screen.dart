import 'dart:async';
import 'package:dpp_mobile/database/database.dart';
import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/services/odoo_service.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> redirectFunction() async {
    localSession = await DatabaseHelper.instance.getAllQuery("session");
    if (localSession!.isEmpty) {
      Timer(const Duration(seconds: 5), () => context.replace('/login'));
    } else {
      try {
        await OdooService().authentication(
            localSession!.first['user_login'], localSession!.first['password']);
        Timer(const Duration(seconds: 5), () => context.replace('/dashboard'));
      } catch (e) {
        await DatabaseHelper.instance.truncateQuery("session");
        Timer(const Duration(seconds: 5), () => context.replace('/login'));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    redirectFunction();
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
