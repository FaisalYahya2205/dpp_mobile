// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/services/odoo_service.dart';
import 'package:dpp_mobile/ui/dashboard_home/widgets/dashboard_home_error.dart';
import 'package:dpp_mobile/ui/dashboard_home/widgets/dashboard_home_loading.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';

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
      cameras.first,
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

      final odooResponse = await OdooService().postCheckOutAttendance(
        currentTime.value,
        currentPositionLatitude.value,
        currentPositionLongitude.value,
        base64,
        descController.text,
      );

      if (odooResponse) {
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
                      quarterTurns: 1,
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
                    top: MediaQuery.of(context).viewPadding.top,
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
                            future: OdooService().getCurrentPosition(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const DashboardHomeLoading();
                              }

                              if (snapshot.hasError) {
                                return const DashboardHomeError();
                              }

                              currentPositionLatitude.value =
                                  snapshot.data!.latitude;
                              currentPositionLongitude.value =
                                  snapshot.data!.longitude;

                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(24),
                                    ),
                                    child: FlutterMap(
                                      options: MapOptions(
                                        initialCenter: LatLng(
                                          currentPositionLatitude.value,
                                          currentPositionLongitude.value,
                                        ),
                                        initialZoom: 16,
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          userAgentPackageName:
                                              'com.example.dpp_mobile',
                                        ),
                                        MarkerLayer(
                                          markers: [
                                            Marker(
                                              point: LatLng(
                                                currentPositionLatitude.value,
                                                currentPositionLongitude.value,
                                              ),
                                              child: const Icon(
                                                Icons.location_pin,
                                                color: Colors.red,
                                                size: 32,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        margin: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color:
                                                    Colors.orange.withAlpha(50),
                                              ),
                                              child: const Icon(
                                                Icons.location_pin,
                                                color: Colors.orange,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Lokasi saat ini",
                                                  style:
                                                      createBlackThinTextStyle(
                                                          12),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "${snapshot.data!.latitude}, ${snapshot.data!.longitude}",
                                                  style:
                                                      createBlackTextStyle(14),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        margin: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          controller: descController,
                                          keyboardType: TextInputType.text,
                                          style: createBlackTextStyle(14),
                                          minLines: 1,
                                          maxLines: 4,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Aktivitas hari ini",
                                            hintStyle:
                                                createGreyThinTextStyle(14),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 4,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'email tidak boleh kosong';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
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
                            debugPrint("CHECK OUT STATUS => Loading");
                            bool checkOutSuccess = await checkOut();
                            if (checkOutSuccess) {
                              debugPrint("CHECK OUT STATUS => Loading");
                              Navigator.of(context).pop(true);
                            } else {
                              debugPrint("CHECK OUT STATUS => Failed");
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
