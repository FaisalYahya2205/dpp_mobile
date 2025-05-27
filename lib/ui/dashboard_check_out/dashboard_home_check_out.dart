// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/services/attendance_service.dart';
import 'package:dpp_mobile/services/location_service.dart';
import 'package:dpp_mobile/ui/dashboard_check_out/widgets/check_out_maps_error.dart';
import 'package:dpp_mobile/ui/dashboard_check_out/widgets/check_out_maps_loading.dart';
import 'package:dpp_mobile/ui/dashboard_check_out/widgets/check_out_maps_success.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/dialogs/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DashboardHomeCheckOut extends StatefulWidget {
  const DashboardHomeCheckOut({super.key});

  @override
  State<DashboardHomeCheckOut> createState() => _DashboardHomeCheckOutState();
}

class _DashboardHomeCheckOutState extends State<DashboardHomeCheckOut> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  ValueNotifier<String> currentShowTime = ValueNotifier<String>("");
  ValueNotifier<String> currentTime = ValueNotifier<String>("");
  ValueNotifier<double> currentPositionLatitude = ValueNotifier<double>(0);
  ValueNotifier<double> currentPositionLongitude = ValueNotifier<double>(0);

  final _formKey = GlobalKey<FormState>();
  TextEditingController descController = TextEditingController();

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

  Future<bool> checkOut() async {
    bool returnValue = false;
    try {
      final XFile picture = await _controller.takePicture();
      final Uint8List bytes = await picture.readAsBytes();
      String base64 = base64Encode(bytes);

      final odooResponse = await AttendanceService().postCheckOutAttendance(
        currentTime.value,
        currentPositionLatitude.value,
        currentPositionLongitude.value,
        base64,
        descController.text,
      );

      if (odooResponse["success"]) {
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
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
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
                        "Check Out",
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
                              color: Colors.orange.withAlpha(50),
                            ),
                            child: const Icon(
                              Iconsax.clock,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Waktu check out",
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
                  height: MediaQuery.of(context).size.height / 2.5,
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
                            color: Colors.grey.shade200,
                          ),
                          child: FutureBuilder(
                            future: const LocationService().getCurrentPosition(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CheckOutMapsLoading();
                              }
                        
                              if (snapshot.hasError) {
                                return const CheckOutMapsError();
                              }
                        
                              currentPositionLatitude.value =
                                  snapshot.data!.latitude;
                              currentPositionLongitude.value =
                                  snapshot.data!.longitude;
                        
                              return CheckOutMapsSuccess(
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
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: descController,
                          keyboardType: TextInputType.text,
                          style: createBlackTextStyle(14),
                          minLines: 3,
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            hintText: "Aktivitas hari ini",
                            hintStyle: createGreyThinTextStyle(14),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 16,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'apa yang anda kerjakan hari ini?';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext dialogContext) =>
                                  AppDialog(
                                type: "loading",
                                title: "Memproses",
                                message: "Mohon tunggu...",
                                onOkPress: () {},
                              ),
                            );
                            bool checkOutSuccess = await checkOut();
                            if (checkOutSuccess) {
                              // dismiss loading dialog
                              Navigator.of(context).pop();
                              // show success dialog
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext dialogContext) =>
                                    AppDialog(
                                  type: "success",
                                  title: "Check Out Berhasil",
                                  message: "Kembali ke dashboard...",
                                  onOkPress: () {},
                                ),
                              );
                              Future.delayed(const Duration(seconds: 2), () {
                                // dismiss loading dialog
                                Navigator.of(context).pop();
                                // back to dashboard
                                Navigator.of(context).pop(true);
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
                                  title: "Check Out Gagal",
                                  message: "Terjadi kesalahan...",
                                  onOkPress: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Text(
                            "Check Out",
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
      ),
    );
  }
}
