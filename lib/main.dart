// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:camera/camera.dart';
import 'package:dpp_mobile/database/database.dart';
import 'package:dpp_mobile/routing/app_routing.dart';
import 'package:dpp_mobile/utils/app_bloc_observer.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

OdooClient? client;
DatabaseHelper? databaseHelper;
List<Map<String, dynamic>>? localSession;
List<Map<String, dynamic>>? localHost;
late List<CameraDescription> cameras;
late bool offlineMode;

var subscription;
var loginSubscription;
var inRequestSubscription;

void main() async {
  // declare bloc observer
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  cameras = await availableCameras();
  Bloc.observer = const AppBlocObserver();
  // init local database & env file
  databaseHelper = DatabaseHelper.instance;
  await databaseHelper!.initDb();
  await dotenv.load(fileName: ".env");

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'HR Attendee',
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: "Lexend",
        primaryColor: AppColors().primaryColor,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
