import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';

class DashboardTimesheet extends StatelessWidget {
  const DashboardTimesheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Timesheet Page",
          style: createBlackTextStyle(32),
        ),
      ),
    );
  }
}