import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/models/overtime.dart';
import 'package:dpp_mobile/repository/employee_repository.dart';
import 'package:dpp_mobile/repository/overtime_repository.dart';
import 'package:dpp_mobile/services/overtime_service.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:translator/translator.dart';

class DetailOvertime extends StatelessWidget {
  const DetailOvertime({
    super.key,
    required this.overtime,
  });

  final Overtime overtime;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => OvertimeRepository(service: OvertimeService(translator: GoogleTranslator())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EmployeeBloc>(
            create: (context) => EmployeeBloc(
              employeeRepository: context.read<EmployeeRepository>(),
            )..add(const GetEmployee()),
          ),
        ],
        child: Scaffold(
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
              overtime.name!,
              style: createBlackTextStyle(18),
            ),
            actions: [
              overtime.state == "draft" && overtime.nextReview == null
                  ? TextButton(
                      onPressed: () {},
                      child: Text(
                        "Edit",
                        style: createPrimaryTextStyle(14),
                      ))
                  : const SizedBox(),
            ],
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Status Overtime",
                          style: createBlackTextStyle(14),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: overtime.state! == "approved"
                                ? Colors.green.shade100
                                : overtime.state! == "f_approve"
                                    ? Colors.yellow.shade100
                                    : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Text(
                            overtime.state! == "f_approve"
                                ? "Waiting"
                                : "${overtime.state![0].toUpperCase()}${overtime.state!.substring(1)}",
                            style: overtime.state! == "approved"
                                ? createGreenMediumTextStyle(12)
                                : overtime.state! == "f_approve"
                                    ? createYellowMediumTextStyle(12)
                                    : createGreyMediumTextStyle(12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  overtime.nextReview != null
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24.0),
                          padding: const EdgeInsets.all(16.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade100,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Iconsax.info_circle,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Catatan ini perlu divalidasi",
                                    style: createGreyTextStyle(14),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                overtime.nextReview!,
                                style: createGreyTextStyle(14),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  overtime.nextReview != null
                      ? const SizedBox(
                          height: 16,
                        )
                      : const SizedBox(),
                  overtime.state == "draft"
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors().primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              overtime.nextReview != null
                                  ? "Ulangi Validasi"
                                  : "Minta Validasi",
                              style: createWhiteBoldTextStyle(14),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Karyawan",
                          style: createBlackTextStyle(14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          overtime.employeeId![1],
                          style: createBlackThinTextStyle(14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Departemen",
                          style: createBlackTextStyle(14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          overtime.departmentId![1],
                          style: createBlackThinTextStyle(14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pekerjaan",
                          style: createBlackTextStyle(14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          overtime.jobId![1],
                          style: createBlackThinTextStyle(14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Waktu Mulai",
                          style: createBlackTextStyle(14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          DateTime.parse("${overtime.dateFrom!}Z")
                              .toUtc()
                              .toLocal()
                              .toString()
                              .split(".")[0],
                          style: createBlackThinTextStyle(14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Waktu Selesai",
                          style: createBlackTextStyle(14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          DateTime.parse("${overtime.dateTo!}Z")
                              .toUtc()
                              .toLocal()
                              .toString()
                              .split(".")[0],
                          style: createBlackThinTextStyle(14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jumlah Jam",
                          style: createBlackTextStyle(14),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          overtime.daysNoTmp!.toStringAsFixed(2),
                          style: createBlackThinTextStyle(14),
                        ),
                      ],
                    ),
                  ),
                  overtime.state != "draft"
                      ? const SizedBox(
                          height: 24,
                        )
                      : const SizedBox(),
                  overtime.state != "draft"
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "TUL",
                                style: createBlackTextStyle(14),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                overtime.rateHours!.toString(),
                                style: createBlackThinTextStyle(14),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  overtime.state != "draft"
                      ? const SizedBox(
                          height: 24,
                        )
                      : const SizedBox(),
                  overtime.state != "draft"
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tipe Overtime",
                                style: createBlackTextStyle(14),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                overtime.overtimeTypeId!["name"],
                                style: createBlackThinTextStyle(14),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  overtime.state != "draft"
                      ? const SizedBox(
                          height: 24,
                        )
                      : const SizedBox(),
                  overtime.state != "draft"
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Karyawan",
                                style: createBlackTextStyle(14),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                overtime.employeeId![1],
                                style: createBlackThinTextStyle(14),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 24,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
