import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class DashboardProfileError extends StatelessWidget {
  const DashboardProfileError({super.key});

  @override
  Widget build(BuildContext context) {
    final employeeBloc = BlocProvider.of<EmployeeBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async => employeeBloc.add(GetEmployee()),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
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
                    color: AppColors().primaryColor.shade50.withAlpha(50),
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
            ),
          ),
        ),
      ),
    );
  }
}
