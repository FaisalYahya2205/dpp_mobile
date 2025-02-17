import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';

class AttendanceHistoryError extends StatelessWidget {
  const AttendanceHistoryError({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Center(
        child: Text(
          "Bila masih terjadi kendala harap hubungi Admin untuk info lebih lanjut...",
          style: createBlackThinTextStyle(14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
