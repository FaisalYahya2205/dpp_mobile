import 'package:dpp_mobile/models/attendance.dart';
import 'package:dpp_mobile/models/overtime.dart';
import 'package:dpp_mobile/ui/attendance_history/attendance_history.dart';
import 'package:dpp_mobile/ui/attendance_history/attendance_history_detail.dart';
import 'package:dpp_mobile/ui/dashboard.dart';
import 'package:dpp_mobile/ui/dashboard_check_in/dashboard_home_check_in_survey.dart';
import 'package:dpp_mobile/ui/dashboard_overtime/add_edit_overtime.dart';
import 'package:dpp_mobile/ui/dashboard_overtime/detail_overtime.dart';
import 'package:dpp_mobile/ui/forgot_password.dart';
import 'package:dpp_mobile/ui/login.dart';
import 'package:dpp_mobile/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: '/dashboard',
          name: 'dashboard',
          builder: (BuildContext context, GoRouterState state) {
            return const DashboardPage();
          },
        ),
        GoRoute(
          path: '/attendance_history',
          name: 'attendance_history',
          builder: (BuildContext context, GoRouterState state) {
            return const AttendanceHistory();
          },
        ),
        GoRoute(
          path: '/attendance_history_detail',
          name: 'attendance_history_detail',
          builder: (BuildContext context, GoRouterState state) {
            return AttendaceHistoryDetail(
              attendanceItem: state.extra as Attendance,
            );
          },
        ),
        GoRoute(
          path: '/forget_password',
          name: 'forget_password',
          builder: (BuildContext context, GoRouterState state) {
            return const ForgotPassword();
          },
        ),
        GoRoute(
          path: '/add_overtime',
          name: 'add_overtime',
          builder: (BuildContext context, GoRouterState state) {
            return const AddEditOvertime();
          },
        ),
        GoRoute(
          path: '/detail_overtime',
          name: 'detail_overtime',
          builder: (BuildContext context, GoRouterState state) {
            return DetailOvertime(
              overtime: state.extra as Overtime,
            );
          },
        ),
        GoRoute(
          path: '/check_in_survey',
          name: 'check_in_survey',
          builder: (
            BuildContext context,
            GoRouterState state,
          ) {
            return DashboardHomeCheckInSurvey(attendanceId: state.extra as int);
          },
        ),
      ],
    ),
  ],
);
