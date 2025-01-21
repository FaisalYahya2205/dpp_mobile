import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardHomeLoading extends StatelessWidget {
  const DashboardHomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
