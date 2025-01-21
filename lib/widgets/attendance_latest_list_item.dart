import 'package:dpp_mobile/models/attendance.dart';
import 'package:dpp_mobile/ui/attendance_history/attendance_history_detail.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Widget latestAttendanceListItem(
        Attendance attendanceListItem, BuildContext context) =>
    GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return AttendaceHistoryDetail(
                attendanceItem: attendanceListItem,
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: AppColors().primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(
                        Iconsax.login_1,
                        color: AppColors().primaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Check In",
                      style: createBlackMediumTextStyle(16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  attendanceListItem.check_in == null
                      ? "-"
                      : attendanceListItem.check_in.toString(),
                  style: createBlackThinTextStyle(14),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: AppColors().primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(
                        Iconsax.logout_1,
                        color: AppColors().primaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Check Out",
                      style: createBlackMediumTextStyle(16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  attendanceListItem.check_out == null
                      ? "-"
                      : attendanceListItem.check_out.toString(),
                  style: createBlackThinTextStyle(14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
