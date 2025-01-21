// ignore_for_file: use_build_context_synchronously

import 'package:dpp_mobile/bloc/attendance_bloc.dart';
import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/ui/attendance_history/attendance_history.dart';
import 'package:dpp_mobile/ui/dashboard_check_in/dashboard_home_check_in.dart';
import 'package:dpp_mobile/ui/dashboard_check_out/dashboard_home_check_out.dart';
import 'package:dpp_mobile/ui/dashboard_home/widgets/dashboard_home_error.dart';
import 'package:dpp_mobile/ui/dashboard_home/widgets/dashboard_home_loading.dart';
import 'package:dpp_mobile/ui/dashboard_home/widgets/dashboard_home_profile_part.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/attendance_latest_list_item.dart';
import 'package:dpp_mobile/widgets/attendance_today_card.dart';
import 'package:dpp_mobile/widgets/swipe_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top,
              ),
              BlocBuilder<EmployeeBloc, EmployeeState>(
                builder: (context, state) {
                  if (state.status.isSuccess) {
                    return ProfilePart(employee: state.employee);
                  } else if (state.status.isError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: Text(
                          "Terjadi Kesalahan",
                          style: createBlackTextStyle(14),
                        ),
                      ),
                    );
                  } else if (state.status.isLoading) {
                    return const DashboardHomeLoading();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<AttendanceBloc>(context)
                          .add(GetAttendance());
                      BlocProvider.of<EmployeeBloc>(context).add(GetEmployee());
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Kehadiran Terbaru Hari Ini",
                              style: createBlackMediumTextStyle(14),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            BlocBuilder<EmployeeBloc, EmployeeState>(
                              builder: (context, state) {
                                if (state.status.isSuccess) {
                                  return Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      todayAttendanceCard(
                                        "Check In",
                                        state.employee.last_check_in == null
                                            ? "-"
                                            : state.employee.last_check_in
                                                .toString()
                                                .split(" ")[0],
                                        state.employee.last_check_in == null
                                            ? "-"
                                            : state.employee.last_check_in
                                                .toString()
                                                .split(" ")[1],
                                        Iconsax.login_1,
                                      ),
                                      const SizedBox(
                                        width: 16.0,
                                      ),
                                      todayAttendanceCard(
                                        "Check Out",
                                        state.employee.last_check_out == null
                                            ? "-"
                                            : state.employee.last_check_out
                                                .toString()
                                                .split(" ")[0],
                                        state.employee.last_check_out == null
                                            ? "-"
                                            : state.employee.last_check_out
                                                .toString()
                                                .split(" ")[1],
                                        Iconsax.logout_1,
                                      ),
                                    ],
                                  );
                                } else if (state.status.isError) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 40.0),
                                      child: Text(
                                        "Terjadi Kesalahan",
                                        style: createBlackTextStyle(14),
                                      ),
                                    ),
                                  );
                                } else if (state.status.isLoading) {
                                  return const DashboardHomeLoading();
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                            const SizedBox(
                              height: 32.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Aktivitasmu",
                                  style: createBlackMediumTextStyle(14),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return const AttendanceHistory();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Lihat Lainnya",
                                    style: createPrimaryBoldTextStyle(14),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            BlocBuilder<AttendanceBloc, AttendanceState>(
                              builder: (context, state) {
                                if (state.status.isSuccess) {
                                  return ListView.builder(
                                    itemCount: 5,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(0),
                                    itemBuilder: (context, index) {
                                      return latestAttendanceListItem(
                                        state.attendances[index],
                                        context,
                                      );
                                    },
                                  );
                                } else if (state.status.isError) {
                                  return const DashboardHomeError();
                                } else if (state.status.isLoading) {
                                  return const DashboardHomeLoading();
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                            const SizedBox(
                              height: 96.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (context, state) {
              if (state.status.isSuccess) {
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
                        BlocProvider.of<AttendanceBloc>(context)
                            .add(GetAttendance());
                        BlocProvider.of<EmployeeBloc>(context)
                            .add(GetEmployee());
                      }
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
