import 'package:dpp_mobile/ui/dashboard.dart';
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
          path: '/forget_password',
          name: 'forget_password',
          builder: (BuildContext context, GoRouterState state) {
            return const ForgotPassword();
          },
        ),
      ],
    ),
  ],
);
