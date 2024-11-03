import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';

class DashboardOvertime extends StatelessWidget {
  const DashboardOvertime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Overtime Page",
          style: createBlackTextStyle(32),
        ),
      ),
    );
  }
}
