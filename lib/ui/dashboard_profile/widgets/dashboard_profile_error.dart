import 'package:dpp_mobile/bloc/employee_bloc.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardProfileError extends StatelessWidget {
  const DashboardProfileError({super.key});

  @override
  Widget build(BuildContext context) {
    final employeeBloc = BlocProvider.of<EmployeeBloc>(context);
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Text(
            'Terjadi Kesalahan',
            style: createBlackTextStyle(14),
          ),
          const SizedBox(
            height: 32,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            height: 48,
            child: ElevatedButton(
              onPressed: () => employeeBloc.add(GetEmployee()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors().primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Muat Ulang",
                style: createWhiteBoldTextStyle(14),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
