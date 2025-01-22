import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';

class DashboardHomeProfileLoading extends StatelessWidget {
  const DashboardHomeProfileLoading({super.key});

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
              color: Colors.grey.shade200,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 256,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.shade200,
                ),
                child: Text(
                  "",
                  style: createBlackTextStyle(20),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: 128,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.shade200,
                ),
                child: Text(
                  "",
                  style: createBlackThinTextStyle(14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
