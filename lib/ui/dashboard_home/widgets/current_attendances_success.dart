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
      itemCount: attendanceList.length > 5 ? 5 : attendanceList.length,
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
        DateTime checkInDateTime =
            DateTime.parse("${attendanceList[index].checkIn}Z").toLocal();
        checkInTimeZone = checkInDateTime.timeZoneName;
        checkInDate = DateFormat.yMMMd().format(checkInDateTime);
        String checkInHour = checkInDateTime.hour.toString().length == 1
            ? "0${checkInDateTime.hour}"
            : checkInDateTime.hour.toString();
        String checkInMinutes = checkInDateTime.minute.toString().length == 1
            ? "0${checkInDateTime.minute}"
            : checkInDateTime.minute.toString();
        checkInTime = "$checkInHour:$checkInMinutes";

        DateTime checkOutDateTime =
            DateTime.parse("${attendanceList[index].checkOut}Z").toLocal();
        checkOutTimeZone = checkOutDateTime.timeZoneName;
        checkOutDate = DateFormat.yMMMd().format(checkOutDateTime);
        String checkOutHour = checkOutDateTime.hour.toString().length == 1
            ? "0${checkOutDateTime.hour}"
            : checkOutDateTime.hour.toString();
        String checkOutMinutes = checkOutDateTime.minute.toString().length == 1
            ? "0${checkOutDateTime.minute}"
            : checkOutDateTime.minute.toString();
        checkOutTime = "$checkOutHour:$checkOutMinutes";

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
            margin: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Column(
              children: [
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors().primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Text(
                          checkInDate,
                          style: createBlackThinTextStyle(14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors().primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          checkOutDate,
                          style: createBlackThinTextStyle(14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors().primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Icon(
                                    Iconsax.login_1,
                                    color: AppColors().primaryColor,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Check In",
                                      style: createBlackThinTextStyle(12),
                                    ),
                                    const SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                      "$checkInTime $checkInTimeZone",
                                      style: createBlackMediumTextStyle(14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors().primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Icon(
                                    Iconsax.logout_1,
                                    color: AppColors().primaryColor,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Check Out",
                                      style: createBlackThinTextStyle(12),
                                    ),
                                    const SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                      "$checkOutTime $checkOutTimeZone",
                                      style: createBlackMediumTextStyle(14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
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
