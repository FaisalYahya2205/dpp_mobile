import 'package:dpp_mobile/utils/constants/attendance_list.dart';
import 'package:dpp_mobile/utils/constants/calendar_sample.dart';
import 'package:dpp_mobile/utils/constants/profile_sample.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/list_calendar_item.dart';
import 'package:dpp_mobile/widgets/attendance_latest_list_item.dart';
import 'package:dpp_mobile/widgets/attendance_today_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  bool isCheckIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top,
          ),
          Padding(
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
                    color: AppColors().primaryColor.shade50.withOpacity(0.25),
                  ),
                  child: Icon(
                    Iconsax.profile_2user,
                    color: AppColors().primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileSample["name"],
                      style: createBlackTextStyle(20),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Fullstack Developer",
                      style: createBlackThinTextStyle(14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (Map<String, dynamic> calendarItem in calendarSample)
                  calendarListItem(calendarItem),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Kehadiran Hari Ini",
                        style: createBlackMediumTextStyle(14),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          todayAttendanceCard(
                            "Check In",
                            "07:54 am",
                            "Tepat Waktu",
                            Iconsax.login_1,
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          todayAttendanceCard(
                            "Check Out",
                            "-",
                            "-",
                            Iconsax.logout_1,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          todayAttendanceCard(
                            "Health",
                            "Check In",
                            "Sehat",
                            Iconsax.health,
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          todayAttendanceCard(
                            "Happiness",
                            "Check Out",
                            "-",
                            Iconsax.happyemoji,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Aktivitasmu",
                            style: createBlackMediumTextStyle(14),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Lihat Lainnya",
                              style: createPrimaryBoldTextStyle(14),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ListView.builder(
                        itemCount: attendanceListSamples.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          return latestAttendanceListItem(
                            attendanceListSamples[index],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
