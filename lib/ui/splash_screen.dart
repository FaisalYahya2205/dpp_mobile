import 'dart:async';
import 'package:dpp_mobile/database/database.dart';
import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/services/authentication_service.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:translator/translator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> requestPermissions() async {
    await [
      Permission.camera,
      Permission.location,
    ].request();

    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus locationStatus = await Permission.location.status;

    debugPrint("CAMERA PERMISSION => ${cameraStatus.toString()}");
    debugPrint("LOCATION PERMISSION => ${locationStatus.toString()}");

    redirectFunction();
  }

  Future<void> redirectFunction() async {
    localSession = await DatabaseHelper.instance.getAllQuery(
      "session",
      "login_state = ?",
      [1],
    );
    localHost = await DatabaseHelper.instance.getAllQuery(
      "host_address",
      "user_id = ?",
      [localSession!.isEmpty ? "" : localSession!.first["user_id"]],
    );
    debugPrint("LOCAL SESSION => $localSession");
    debugPrint("LOCAL HOST => $localHost");

    if (localSession!.isEmpty) {
      Timer(
        const Duration(seconds: 3),
        () => context.pushReplacement('/login'),
      );
      return;
    }

    try {
      await AuthenticationService(translator: GoogleTranslator()).authentication(
        localSession!.first['user_login'],
        localSession!.first['password'],
        localHost!.first["host_url"],
        localHost!.first["database_name"],
      );

      Timer(
        const Duration(seconds: 3),
        () => context.pushReplacement('/dashboard'),
      );
    } catch (e) {
      Timer(
        const Duration(seconds: 3),
        () => context.pushReplacement('/login'),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();
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
