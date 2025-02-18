// ignore_for_file: use_build_context_synchronously

import 'package:dpp_mobile/services/employee_service.dart';
import 'package:dpp_mobile/services/overtime_service.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/dialogs/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:iconsax/iconsax.dart';

class AddEditOvertime extends StatefulWidget {
  const AddEditOvertime({super.key});

  @override
  State<AddEditOvertime> createState() => _AddEditOvertimeState();
}

class _AddEditOvertimeState extends State<AddEditOvertime> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController employeeTextController = TextEditingController();
  TextEditingController dateFromTextController = TextEditingController();
  TextEditingController dateToTextController = TextEditingController();
  TextEditingController attchTextController = TextEditingController();
  TextEditingController descTextController = TextEditingController();

  Future<bool> requestOvertime(BuildContext context) async {
    bool returnValue = false;
    try {
      final odooResponse = await OvertimeService().postOvertimeRequest(
        DateTime.parse(dateFromTextController.text)
            .toUtc()
            .toString()
            .split(".")[0],
        DateTime.parse(dateToTextController.text)
            .toUtc()
            .toString()
            .split(".")[0],
        attchTextController.text,
        descTextController.text,
      );

      if (odooResponse.runtimeType == int && odooResponse != 0) {
        returnValue = true;
      }
    } catch (e) {
      debugPrint("Check In Failed => ${e.toString()}");
      return false;
    }

    return returnValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(false);
          },
          child: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Buat Pengajuan",
          style: createBlackTextStyle(18),
        ),
      ),
      body: FutureBuilder(
        future: EmployeeService().getEmployee(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: const LinearProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: const LinearProgressIndicator(),
              ),
            );
          } else {
            employeeTextController.text = snapshot.data!["data"].name!;
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Nama Karyawan",
                        style: createBlackMediumTextStyle(14),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(
                        controller: employeeTextController,
                        enabled: false,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors().primaryColor,
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          errorStyle: createRedThinTextStyle(12),
                          contentPadding: const EdgeInsets.all(16.0),
                          hintText: "Nama Karyawan",
                          hintStyle: createGreyThinTextStyle(14),
                        ),
                        style: createBlackTextStyle(14),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Data Karyawan tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Tanggal dan Waktu Mulai",
                        style: createBlackMediumTextStyle(14),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: GestureDetector(
                        onTap: () {
                          picker.DatePicker.showDateTimePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (date) {
                              dateFromTextController.text =
                                  date.toString().split(".")[0];
                              debugPrint(date.toUtc().toString().split(".")[0]);
                            },
                            currentTime: DateTime.now(),
                          );
                        },
                        child: TextFormField(
                          controller: dateFromTextController,
                          enabled: false,
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: AppColors().primaryColor,
                                width: 1,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            errorStyle: createRedThinTextStyle(12),
                            hintText: "YYYY-MM-DD HH:mm:ss",
                            contentPadding: const EdgeInsets.all(16.0),
                            hintStyle: createGreyThinTextStyle(14),
                            suffixIcon: const Icon(Iconsax.calendar_1),
                          ),
                          style: createBlackTextStyle(14),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tanggal dan waktu mulai tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Tanggal dan Waktu Selesai",
                        style: createBlackMediumTextStyle(14),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: GestureDetector(
                        onTap: () {
                          picker.DatePicker.showDateTimePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (date) {
                              dateToTextController.text =
                                  date.toString().split(".")[0];
                              debugPrint(date.toUtc().toString().split(".")[0]);
                            },
                            currentTime: DateTime.now(),
                          );
                        },
                        child: TextFormField(
                          controller: dateToTextController,
                          enabled: false,
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: AppColors().primaryColor,
                                width: 1,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            errorStyle: createRedThinTextStyle(12),
                            hintText: "YYYY-MM-DD HH:mm:ss",
                            contentPadding: const EdgeInsets.all(16.0),
                            hintStyle: createGreyThinTextStyle(14),
                            suffixIcon: const Icon(Iconsax.calendar_1),
                          ),
                          style: createBlackTextStyle(14),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tanggal dan waktu selesai tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Deksripsi",
                        style: createBlackMediumTextStyle(14),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(
                        controller: descTextController,
                        minLines: 3,
                        maxLines: 5,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors().primaryColor,
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(16.0),
                          errorStyle: createRedThinTextStyle(12),
                        ),
                        style: createBlackTextStyle(14),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Deskripsi tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
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

                            if (dateFromTextController.text
                                    .compareTo(dateToTextController.text) >
                                0) {
                              Navigator.of(context).pop();
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext dialogContext) =>
                                    AppDialog(
                                  type: "error",
                                  title: "Rentang Waktu Tidak Valid",
                                  message:
                                      "Tanggal dan Waktu Mulai tidak boleh lebih besar dari Tanggal dan Waktu Selesai",
                                  onOkPress: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              );
                              return;
                            }

                            bool checkOutSuccess =
                                await requestOvertime(context);

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
                                  title: "Pengajuan Berhasil",
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
                                  title: "Pengajuan Gagal",
                                  message: "Terjadi kesalahan...",
                                  onOkPress: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors().primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Ajukan",
                          style: createWhiteBoldTextStyle(14),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
