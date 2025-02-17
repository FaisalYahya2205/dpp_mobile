import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DashboardHomeProfileError extends StatelessWidget {
  const DashboardHomeProfileError({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.shade100,
            ),
            child: const Icon(
              Iconsax.warning_2,
              size: 48,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Terjadi Kesalahan",
                style: createBlackTextStyle(20),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Gagal mengambil data...",
                style: createGreyThinTextStyle(14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
