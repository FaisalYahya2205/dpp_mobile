import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';

class AttendanceHistoryLoading extends StatelessWidget {
  const AttendanceHistoryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: ListView.builder(
        itemCount: 5,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "",
                      style: createBlackMediumTextStyle(16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "",
                  style: createBlackThinTextStyle(14),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
