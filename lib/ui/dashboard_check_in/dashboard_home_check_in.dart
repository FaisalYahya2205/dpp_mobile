// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/services/attendance_service.dart';
import 'package:dpp_mobile/services/location_service.dart';
import 'package:dpp_mobile/ui/dashboard_check_in/widgets/check_in_maps_error.dart';
import 'package:dpp_mobile/ui/dashboard_check_in/widgets/check_in_maps_loading.dart';
import 'package:dpp_mobile/ui/dashboard_check_in/widgets/check_in_maps_success.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/dialogs/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class DashboardHomeCheckIn extends StatefulWidget {
  const DashboardHomeCheckIn({super.key});

  @override
  State<DashboardHomeCheckIn> createState() => _DashboardHomeCheckInState();
}

class _DashboardHomeCheckInState extends State<DashboardHomeCheckIn> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  ValueNotifier<int> attendanceId = ValueNotifier<int>(0);
  ValueNotifier<String> currentShowTime = ValueNotifier<String>("");
  ValueNotifier<String> currentTime = ValueNotifier<String>("");
  ValueNotifier<double> currentPositionLatitude = ValueNotifier<double>(0);
  ValueNotifier<double> currentPositionLongitude = ValueNotifier<double>(0);

  String? checkInState;

  @override
  void initState() {
    super.initState();
    currentShowTime.value = DateTime.now().toLocal().toString().split(".")[0];
    currentTime.value = DateTime.now().toUtc().toString().split(".")[0];

    _controller = CameraController(
      cameras.length > 1 ? cameras[1] : cameras[0],
      ResolutionPreset.medium,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> checkIn(BuildContext context) async {
    bool returnValue = false;
    try {
      final XFile picture = await _controller.takePicture();
      final Uint8List bytes = await picture.readAsBytes();
      String base64 = base64Encode(bytes);

      Map<String, dynamic> odooResponse = await AttendanceService()
          .postCheckInAttendance(
              currentTime.value,
              currentPositionLatitude.value,
              currentPositionLongitude.value,
              base64);

      if (odooResponse["data"].runtimeType == int) {
        attendanceId.value = odooResponse["data"];
        returnValue = true;
      }
    } catch (e) {
      debugPrint("Check In Failed => ${e.toString()}");
    }

    return returnValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16.0),
            ),
            constraints: const BoxConstraints.expand(),
            child: FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return RotatedBox(
                    quarterTurns: -1,
                    child: CameraPreview(_controller),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withAlpha(100),
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: const Icon(
                          Iconsax.arrow_left_2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      "Check In",
                      style: createWhiteMediumTextStyle(18),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withAlpha(100),
                      ),
                      child: GestureDetector(
                        onTap: () => {},
                        child: const Icon(
                          Iconsax.menu,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors().primaryColor.withAlpha(50),
                          ),
                          child: Icon(
                            Iconsax.clock,
                            color: AppColors().primaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Waktu check in",
                              style: createBlackThinTextStyle(12),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              currentShowTime.value,
                              style: createBlackTextStyle(14),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Colors.grey.shade100,
                        ),
                        child: FutureBuilder(
                          future: const LocationService().getCurrentPosition(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CheckInMapsLoading();
                            }

                            if (snapshot.hasError) {
                              return const CheckInMapsError();
                            }

                            currentPositionLatitude.value =
                                snapshot.data!.latitude;
                            currentPositionLongitude.value =
                                snapshot.data!.longitude;

                            return CheckInMapsSuccess(
                              currentPositionLatitude:
                                  currentPositionLatitude.value,
                              currentPositionLongitude:
                                  currentPositionLongitude.value,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext dialogContext) => AppDialog(
                              type: "loading",
                              title: "Memproses",
                              message: "Mohon tunggu...",
                              onOkPress: () {},
                            ),
                          );

                          if (currentPositionLatitude.value == 0 ||
                              currentPositionLongitude.value == 0) {
                            // dismiss loading dialog
                            Navigator.of(context).pop();
                            // show error dialog
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext dialogContext) =>
                                  AppDialog(
                                type: "error",
                                title: "Check In Gagal",
                                message: "Data lokasi tidak boleh kosong...",
                                onOkPress: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                            return;
                          }

                          bool checkInSuccess = await checkIn(context);

                          if (checkInSuccess) {
                            // dismiss loading dialog
                            Navigator.of(context).pop();
                            // show success dialog
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext dialogContext) =>
                                  AppDialog(
                                type: "success",
                                title: "Check In Berhasil",
                                message: "Mengalihkan...",
                                onOkPress: () {},
                              ),
                            );

                            Future.delayed(const Duration(seconds: 2), () {
                              // dismiss loading dialog
                              Navigator.of(context).pop();
                              // back to dashboard
                              context.go("/check_in_survey",
                                  extra: attendanceId.value);
                            });
                          } else {
                            // dismiss loading dialog
                            Navigator.of(context).pop();
                            // show error dialog
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext dialogContext) =>
                                  AppDialog(
                                type: "error",
                                title: "Check In Gagal",
                                message: "Terjadi kesalahan...",
                                onOkPress: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors().primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Text(
                          "Check In",
                          style: createWhiteBoldTextStyle(14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
