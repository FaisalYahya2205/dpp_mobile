// ignore_for_file: use_build_context_synchronously

import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/attendance.dart';
import 'package:dpp_mobile/repository/odoo_repository.dart';
import 'package:dpp_mobile/services/odoo_service.dart';
import 'package:dpp_mobile/ui/dashboard_profile/widgets/dashboard_profile_error.dart';
import 'package:dpp_mobile/ui/dashboard_profile/widgets/dashboard_profile_loading.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/dialogs/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AttendaceHistoryDetail extends StatefulWidget {
  const AttendaceHistoryDetail({super.key, required this.attendanceItem});

  final Attendance attendanceItem;

  @override
  State<AttendaceHistoryDetail> createState() => _AttendaceHistoryDetailState();
}

class _AttendaceHistoryDetailState extends State<AttendaceHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => OdooRepository(service: OdooService()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EmployeeBloc>(
            create: (context) => EmployeeBloc(
              odooRepository: context.read<OdooRepository>(),
            )..add(GetEmployee()),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Iconsax.arrow_left_2,
                color: Colors.black,
              ),
            ),
            title: Text(
              "Detail Kehadiran",
              style: createBlackTextStyle(18),
            ),
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.white,
            child: SingleChildScrollView(
              child: BlocBuilder<EmployeeBloc, EmployeeState>(
                builder: (context, state) {
                  if (state.status.isSuccess) {
                    String? checkInDate,
                        checkOutDate,
                        checkInTime,
                        checkOutTime,
                        checkInTimeZone,
                        checkOutTimeZone;

                    DateTime checkInDateTime =
                        DateTime.parse("${widget.attendanceItem.check_in}Z")
                            .toLocal();
                    checkInTimeZone = checkInDateTime.timeZoneName;
                    checkInTimeZone = checkInDateTime.timeZoneName;
                    checkInDate = DateFormat.yMMMd().format(checkInDateTime);
                    String checkInHour =
                        checkInDateTime.hour.toString().length == 1
                            ? "0${checkInDateTime.hour}"
                            : checkInDateTime.hour.toString();
                    String checkInMinutes =
                        checkInDateTime.minute.toString().length == 1
                            ? "0${checkInDateTime.minute}"
                            : checkInDateTime.minute.toString();
                    checkInTime = "$checkInHour:$checkInMinutes";

                    DateTime checkOutDateTime =
                        DateTime.parse("${widget.attendanceItem.check_out}Z")
                            .toLocal();
                    checkOutTimeZone = checkOutDateTime.timeZoneName;
                    checkOutTimeZone = checkOutDateTime.timeZoneName;
                    checkOutDate = DateFormat.yMMMd().format(checkOutDateTime);
                    String checkOutHour =
                        checkOutDateTime.hour.toString().length == 1
                            ? "0${checkOutDateTime.hour}"
                            : checkOutDateTime.hour.toString();
                    String checkOutMinutes =
                        checkOutDateTime.minute.toString().length == 1
                            ? "0${checkOutDateTime.minute}"
                            : checkOutDateTime.minute.toString();
                    checkOutTime = "$checkOutHour:$checkOutMinutes";

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 32.0,
                        ),
                        Container(
                          height: 96,
                          width: 96,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color:
                                AppColors().primaryColor.shade50.withAlpha(50),
                          ),
                          child: Image.network(
                            "https://dpp.tbdigitalindo.co.id/web/image?model=hr.employee&id=${state.employee.id}&field=image_128",
                            headers: {
                              'Cookie':
                                  'session_id=${localSession!.first["session_id"]}',
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          state.employee.name!,
                          style: createBlackTextStyle(20),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          state.employee.job_title!,
                          style: createBlackThinTextStyle(14),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          margin: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          child: Column(
                            children: [
                              Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors()
                                            .primaryColor
                                            .withAlpha(20),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      child: Text(
                                        checkInDate,
                                        style: createBlackThinTextStyle(14),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      margin: const EdgeInsets.all(8.0),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors()
                                            .primaryColor
                                            .withAlpha(20),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: Text(
                                        checkOutDate,
                                        style: createBlackThinTextStyle(14),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  color: AppColors()
                                                      .primaryColor
                                                      .withAlpha(20),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                child: Icon(
                                                  Iconsax.login_1,
                                                  color:
                                                      AppColors().primaryColor,
                                                  size: 24,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 16.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Check In",
                                                    style:
                                                        createBlackThinTextStyle(
                                                            14),
                                                  ),
                                                  const SizedBox(
                                                    height: 4.0,
                                                  ),
                                                  Text(
                                                    "$checkInTime $checkInTimeZone",
                                                    style:
                                                        createBlackMediumTextStyle(
                                                            14),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  color: AppColors()
                                                      .primaryColor
                                                      .withAlpha(20),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                child: Icon(
                                                  Iconsax.logout_1,
                                                  color:
                                                      AppColors().primaryColor,
                                                  size: 24,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 16.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Check Out",
                                                    style:
                                                        createBlackThinTextStyle(
                                                            12),
                                                  ),
                                                  const SizedBox(
                                                    height: 4.0,
                                                  ),
                                                  Text(
                                                    "$checkOutTime $checkOutTimeZone",
                                                    style:
                                                        createBlackMediumTextStyle(
                                                            14),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Lokasi Check In",
                                style: createBlackBoldTextStyle(14),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final mapsUrl = Uri.parse(widget
                                      .attendanceItem.map_url_check_in!
                                      .split('"')[1]);
                                  if (!await launchUrl(mapsUrl)) {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext dialogContext) =>
                                          AppDialog(
                                        type: "error",
                                        title: "Gagal Membuka URL!",
                                        message: "Url salah atau tidak valid",
                                        onOkPress: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "Buka Maps",
                                  style: createPrimaryMediumTextStyle(14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Lokasi Check Out",
                                style: createBlackBoldTextStyle(14),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final mapsUrl = Uri.parse(widget
                                      .attendanceItem.map_url_check_out!
                                      .split('"')[1]);
                                  if (!await launchUrl(mapsUrl)) {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext dialogContext) =>
                                          AppDialog(
                                        type: "error",
                                        title: "Gagal Membuka URL!",
                                        message: "Url salah atau tidak valid",
                                        onOkPress: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "Buka Maps",
                                  style: createPrimaryMediumTextStyle(14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Detail Aktivitas Hari Ini",
                                style: createBlackBoldTextStyle(14),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 48,
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.symmetric(horizontal: 24.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                          ),
                          child: Text(
                            widget.attendanceItem.desc!,
                            style: createBlackThinTextStyle(14),
                          ),
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                      ],
                    );
                  }
                  if (state.status.isError) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).viewPadding.top,
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        Container(
                          height: 72,
                          width: 72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color:
                                AppColors().primaryColor.shade50.withAlpha(50),
                          ),
                          child: const Icon(
                            Iconsax.warning_2,
                            color: Colors.red,
                            size: 64,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Terjadi Kesalahan",
                          style: createBlackTextStyle(20),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Gagal mengambul data...",
                          style: createBlackThinTextStyle(14),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top,
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.shade200,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: 256,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.shade200,
                        ),
                        child: Text(
                          "",
                          style: createBlackTextStyle(20),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 128,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.shade200,
                        ),
                        child: Text(
                          "",
                          style: createBlackThinTextStyle(14),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24.0),
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
