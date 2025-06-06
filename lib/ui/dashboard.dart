// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dpp_mobile/bloc/employee_last_attendance_bloc.dart';
import 'package:dpp_mobile/bloc/attendance/attendance_bloc.dart';
import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/bloc/overtime_bloc.dart';
import 'package:dpp_mobile/database/database.dart';
import 'package:dpp_mobile/repository/attendance_repository.dart';
import 'package:dpp_mobile/repository/employee_repository.dart';
import 'package:dpp_mobile/repository/overtime_repository.dart';
import 'package:dpp_mobile/repository/timesheet_repository.dart';
import 'package:dpp_mobile/services/attendance_service.dart';
import 'package:dpp_mobile/services/employee_service.dart';
import 'package:dpp_mobile/services/overtime_service.dart';
import 'package:dpp_mobile/services/timesheet_service.dart';
import 'package:dpp_mobile/ui/dashboard_timesheet.dart';
import 'package:dpp_mobile/ui/dashboard_home/dashboard_home.dart';
import 'package:dpp_mobile/ui/dashboard_overtime/dashboard_overtime.dart';
import 'package:dpp_mobile/ui/dashboard_profile/dashboard_profile.dart';
import 'package:dpp_mobile/widgets/bottom_navigation_bar_item.dart';
import 'package:dpp_mobile/widgets/dialogs/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:translator/translator.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int pageIndex = 0;

  DateTime? currentPress;

  final pages = [
    const DashboardHome(),
    const DashboardOvertime(),
    const DashboardTimesheet(),
    const DashboardProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (state, value) {
        final now = DateTime.now();
        if (currentPress == null ||
            now.difference(currentPress!) > const Duration(seconds: 2)) {
          currentPress = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tekan sekali lagi untuk keluar'),
              duration: Duration(seconds: 1),
            ),
          );
          return;
        } else {
          debugPrint("EXIT");
          exit(0);
        }
      },
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => EmployeeRepository(service: EmployeeService(translator: GoogleTranslator())),
          ),
          RepositoryProvider(
            create: (context) => AttendanceRepository(service: AttendanceService()),
          ),
          RepositoryProvider(
            create: (context) => OvertimeRepository(service: OvertimeService(translator: GoogleTranslator())),
          ),
          RepositoryProvider(
            create: (context) => TimesheetRepository(service: TimesheetService(translator: GoogleTranslator())),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<EmployeeBloc>(
              create: (context) => EmployeeBloc(
                employeeRepository: context.read<EmployeeRepository>(),
              )..add(const GetEmployee()),
            ),
            BlocProvider<EmployeeLastAttendanceBloc>(
              create: (context) => EmployeeLastAttendanceBloc(
                employeeRepository: context.read<EmployeeRepository>(),
              )..add(const GetEmployeeLastAttendance()),
            ),
            BlocProvider<AttendanceBloc>(
              create: (context) => AttendanceBloc(
                attendanceRepository: context.read<AttendanceRepository>(),
              )..add(const GetAttendance()),
            ),
            BlocProvider<OvertimeBloc>(
              create: (context) => OvertimeBloc(
                overtimeRepository: context.read<OvertimeRepository>(),
              )..add(const GetOvertimeList(overtimeState: "draft")),
            ),
          ],
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  pages[pageIndex],
                ],
              ),
            ),
            bottomNavigationBar: buildMyNavBar(context),
          ),
        ),
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bottomNavItem(
            () => setState(() => pageIndex = 0),
            Iconsax.home_1,
            0,
            pageIndex,
          ),
          bottomNavItem(
            () => setState(() => pageIndex = 1),
            Iconsax.timer_1,
            1,
            pageIndex,
          ),
          bottomNavItem(
            () => setState(() => pageIndex = 2),
            Iconsax.calendar_add,
            2,
            pageIndex,
          ),
          bottomNavItem(
            () => setState(() => pageIndex = 3),
            Iconsax.profile_2user,
            3,
            pageIndex,
          ),
          bottomNavItem(
            () => showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext dialogContext) => AppDialog(
                type: "confirm",
                title: "Logout?",
                message:
                    "Anda harus login kembali jika ingin mengakses aplikasi...",
                onOkPress: () async {
                  context.pop(true);
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) => AppDialog(
                      type: "loading",
                      title: "Memproses",
                      message: "Mohon tunggu...",
                      onOkPress: () {},
                    ),
                  );
                  await DatabaseHelper.instance.logoutQuery("session").then(
                    (result) {
                      context.pop(true);
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) => AppDialog(
                          type: "success",
                          title: "Logout Berhasil",
                          message: "Mengalihkan...",
                          onOkPress: () {},
                        ),
                      );
                      Future.delayed(const Duration(seconds: 2), () {
                        context.pop();
                        context.pushReplacement("/login");
                      });
                    },
                  );
                },
              ),
            ),
            Iconsax.logout,
            4,
            pageIndex,
          ),
        ],
      ),
    );
  }
}
