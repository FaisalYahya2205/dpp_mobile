import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/ui/dashboard_profile/widgets/dashboard_profile_error.dart';
import 'package:dpp_mobile/ui/dashboard_profile/widgets/dashboard_profile_success.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardProfile extends StatefulWidget {
  const DashboardProfile({super.key});

  @override
  State<DashboardProfile> createState() => _DashboardProfileState();
}

class _DashboardProfileState extends State<DashboardProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state.status.isSuccess) {
            return DashboardProfileSuccess(
              employee: state.employee,
            );
          } else if (state.status.isError) {
            return const DashboardProfileError();
          } else if (state.status.isLoading) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: SizedBox(
                  width: 64,
                  child: LinearProgressIndicator(
                    color: AppColors().primaryColor,
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
