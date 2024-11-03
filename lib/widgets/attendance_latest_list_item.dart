import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Widget latestAttendanceListItem(Map<String, dynamic> attendanceListItem) =>
    Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors().primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              attendanceListItem["activity"].toString() == "Check In"
                  ? Iconsax.login_1
                  : Iconsax.logout_1,
              color: AppColors().primaryColor,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                attendanceListItem["activity"].toString(),
                style: createBlackMediumTextStyle(16),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                attendanceListItem["date"].toString(),
                style: createBlackThinTextStyle(14),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                attendanceListItem["time"].toString(),
                style: createBlackMediumTextStyle(16),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                attendanceListItem["status"].toString(),
                style: createBlackThinTextStyle(14),
              ),
            ],
          ),
        ],
      ),
    );
