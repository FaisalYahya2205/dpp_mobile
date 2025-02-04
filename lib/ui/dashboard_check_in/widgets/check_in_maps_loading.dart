import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';

class CheckInMapsLoading extends StatelessWidget {
  const CheckInMapsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.shade200,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(8.0),
                child: const CircularProgressIndicator(),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Memuat Maps",
                    style: createGreyThinTextStyle(12),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Mengambil lokasi saat ini...",
                    style: createGreyTextStyle(14),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
