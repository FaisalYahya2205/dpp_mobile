import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/repository/employee_repository.dart';
import 'package:dpp_mobile/services/employee_service.dart';
import 'package:dpp_mobile/ui/dashboard_timesheet.dart';
import 'package:dpp_mobile/ui/dashboard_home/dashboard_home.dart';
import 'package:dpp_mobile/ui/dashboard_overtime.dart';
import 'package:dpp_mobile/ui/dashboard_profile/dashboard_profile.dart';
import 'package:dpp_mobile/widgets/bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int pageIndex = 0;

  final pages = [
    const DashboardHome(),
    const DashboardOvertime(),
    const DashboardTimesheet(),
    const DashboardProfile(),
  ];

  Future<void> requestPermissions() async {
    await [
      Permission.location,
      Permission.camera,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EmployeeRepository(service: EmployeeService()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EmployeeBloc>(
            create: (context) => EmployeeBloc(
              employeeRepository: context.read<EmployeeRepository>(),
            )..add(GetEmployee()),
          ),
        ],
        child: Scaffold(
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
        ],
      ),
    );
  }
}
