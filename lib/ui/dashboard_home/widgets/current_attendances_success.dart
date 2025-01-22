import 'package:dpp_mobile/models/attendance.dart';
import 'package:dpp_mobile/ui/attendance_history/attendance_history_detail.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class CurrentAttendancesSuccess extends StatelessWidget {
  const CurrentAttendancesSuccess({super.key, required this.attendanceList});

  final List<Attendance> attendanceList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        String? checkInDate,
            checkOutDate,
            checkInTime,
            checkOutTime,
            checkInTimeZone,
            checkOutTimeZone;

        // DateTime checkInDateTime =
        //     DateTime.parse("${attendanceList[index].check_in}Z").toLocal();
        DateTime checkInDateTime =
            DateTime.parse(DateTime.now().toString()).toLocal();
        checkInTimeZone = checkInDateTime.timeZoneName;
        checkInTimeZone = checkInDateTime.timeZoneName;
        checkInDate = DateFormat.yMMMd().format(checkInDateTime);
        checkInTime = "${checkInDateTime.hour}:${checkInDateTime.minute}";

        // DateTime checkOutDateTime =
        //     DateTime.parse("${attendanceList[index].check_out}Z").toLocal();
        DateTime checkOutDateTime =
            DateTime.parse(DateTime.now().toString()).toLocal();
        checkOutTimeZone = checkOutDateTime.timeZoneName;
        checkOutTimeZone = checkOutDateTime.timeZoneName;
        checkOutDate = DateFormat.yMMMd().format(checkOutDateTime);
        checkOutTime = "${checkOutDateTime.hour}:${checkOutDateTime.minute}";

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AttendaceHistoryDetail(
                    attendanceItem: attendanceList[index],
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
                      checkInTime,
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
                      checkOutTime,
                      style: createBlackThinTextStyle(14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
