// ignore_for_file: use_build_context_synchronously

import 'package:dpp_mobile/bloc/employee_last_attendance_bloc.dart';
import 'package:dpp_mobile/bloc/attendance/attendance_bloc.dart';
import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/ui/attendance_history/attendance_history.dart';
import 'package:dpp_mobile/ui/dashboard_check_in/dashboard_home_check_in.dart';
import 'package:dpp_mobile/ui/dashboard_check_out/dashboard_home_check_out.dart';
import 'package:dpp_mobile/ui/dashboard_home/widgets/current_attendances_error.dart';
import 'package:dpp_mobile/ui/dashboard_home/widgets/current_attendances_loading.dart';
import 'package:dpp_mobile/ui/dashboard_home/widgets/current_attendances_success.dart';
import 'package:dpp_mobile/ui/dashboard_home/widgets/dashboard_home_profile_error.dart';
import 'package:dpp_mobile/ui/dashboard_home/widgets/dashboard_home_profile_loading.dart';
import 'package:dpp_mobile/ui/dashboard_home/widgets/dashboard_home_profile_success.dart';
import 'package:dpp_mobile/ui/dashboard_home/widgets/latest_attendance_error.dart';
import 'package:dpp_mobile/ui/dashboard_home/widgets/latest_attendance_loading.dart';
import 'package:dpp_mobile/ui/dashboard_home/widgets/latest_attendance_success.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/swipe_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    void refreshData() {
      BlocProvider.of<AttendanceBloc>(context).add(
        GetAttendance(),
      );
      BlocProvider.of<EmployeeBloc>(context).add(
        GetEmployee(),
      );
      BlocProvider.of<EmployeeLastAttendanceBloc>(context).add(
        GetEmployeeLastAttendance(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top + 16,
              ),
              BlocBuilder<EmployeeBloc, EmployeeState>(
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return const DashboardHomeProfileLoading();
                  }
                  if (state.status.isSuccess) {
                    return DashboardHomeProfileSuccess(
                      employee: state.employee,
                    );
                  }
                  return const DashboardHomeProfileError();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: BlocBuilder<EmployeeBloc, EmployeeState>(
                    builder: (context, state) {
                      if (state.status.isLoading) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Text(
                                "Kehadiran Terbaru Hari Ini",
                                style: createBlackMediumTextStyle(14),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              const LatestAttendanceLoading(),
                              const SizedBox(
                                height: 32.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Aktivitasmu",
                                    style: createBlackMediumTextStyle(14),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              const CurrentAttendancesLoading(),
                            ],
                          ),
                        );
                      }

                      if (state.status.isSuccess && state.employee.id == 0) {
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Center(
                            child: Text(
                              "Anda belum terdaftar sebagai karyawan.\nBila masih terjadi kendala harap hubungi Admin untuk info lebih lanjut...",
                              style: createBlackThinTextStyle(14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async => refreshData(),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  "Kehadiran Terbaru Hari Ini",
                                  style: createBlackMediumTextStyle(14),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                BlocBuilder<EmployeeLastAttendanceBloc,
                                    EmployeeLastAttendanceState>(
                                  builder: (context, state) {
                                    if (state.status.isLoading) {
                                      return const LatestAttendanceLoading();
                                    }
                                    if (state.status.isSuccess) {
                                      return LatestAttendanceSuccess(
                                        employee: state.employee,
                                      );
                                    }
                                    return const LatestAttendanceError();
                                  },
                                ),
                                const SizedBox(
                                  height: 32.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Aktivitasmu",
                                      style: createBlackMediumTextStyle(14),
                                    ),
                                    BlocBuilder<AttendanceBloc,
                                        AttendanceState>(
                                      builder: (context, state) {
                                        if (state.status.isSuccess) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) {
                                                    return const AttendanceHistory();
                                                  },
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Lihat Lainnya",
                                              style: createPrimaryBoldTextStyle(
                                                  14),
                                            ),
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                BlocBuilder<AttendanceBloc, AttendanceState>(
                                  builder: (context, state) {
                                    if (state.status.isLoading) {
                                      return const CurrentAttendancesLoading();
                                    }
                                    if (state.status.isSuccess) {
                                      debugPrint(
                                          "CURRENT ATTENDANCES => ${state.attendances}");
                                      return CurrentAttendancesSuccess(
                                        attendanceList: state.attendances,
                                      );
                                    }
                                    return const CurrentAttendancesError();
                                  },
                                ),
                                const SizedBox(
                                  height: 96.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<EmployeeLastAttendanceBloc, EmployeeLastAttendanceState>(
            builder: (context, state) {
              if (state.status.isSuccess && state.employee.id != 0) {
                bool isCheckIn = true;

                if (state.employee.last_check_in != null &&
                    state.employee.last_check_out == null) {
                  isCheckIn = false;
                }

                return Container(
                  height: MediaQuery.of(context).size.height - 64,
                  alignment: AlignmentDirectional.bottomCenter,
                  child: buildSwipeButton(
                    context,
                    isCheckIn,
                    () async {
                      bool success = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => isCheckIn
                              ? const DashboardHomeCheckIn()
                              : const DashboardHomeCheckOut(),
                        ),
                      );

                      if (success) {
                        refreshData();
                      }
                    },
                  ),
                );
              }

              return Container(
                height: MediaQuery.of(context).size.height - 96,
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: () => refreshData(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors().primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      "Muat Ulang",
                      style: createWhiteBoldTextStyle(14),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
