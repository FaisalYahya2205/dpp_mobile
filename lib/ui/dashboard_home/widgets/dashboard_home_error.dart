import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';

class DashboardHomeError extends StatelessWidget {
  const DashboardHomeError({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Center(
          child: Text(
            'Terjadi Kesalahan',
            style: createBlackTextStyle(14),
          ),
        ),
      ),
    );
  }
}
