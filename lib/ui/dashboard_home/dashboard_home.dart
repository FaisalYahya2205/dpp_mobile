import 'package:dpp_mobile/services/calendar_service.dart';
import 'package:dpp_mobile/services/odoo_service.dart';
import 'package:dpp_mobile/ui/attendance_history.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/calendar_item.dart';
import 'package:dpp_mobile/widgets/attendance_latest_list_item.dart';
import 'package:dpp_mobile/widgets/attendance_today_card.dart';
import 'package:dpp_mobile/widgets/swipe_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  int calendarSelected = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top,
              ),
              FutureBuilder(
                future: OdooService().getEmployeeData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
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
                              color: AppColors()
                                  .primaryColor
                                  .shade50
                                  .withAlpha(50),
                            ),
                            child: Image.network(
                              "https://dpp.tbdigitalindo.co.id/web/image?model=hr.employee&id=${snapshot.data["id"]}&field=image_128",
                              headers: {
                                'Cookie':
                                    'session_id=${snapshot.data['session_id']}',
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data["name"],
                                style: createBlackTextStyle(20),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                snapshot.data["job_title"],
                                style: createBlackThinTextStyle(14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }

                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: SizedBox(
                        width: 64,
                        child: LinearProgressIndicator(
                          color: AppColors().primaryColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: FutureBuilder(
                  future: CalendarService().generateDateList(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (Map<String, dynamic> dateItem in snapshot.data)
                            calendarItem(dateItem, calendarSelected, () {
                              setState(
                                () => calendarSelected = dateItem['day'],
                              );
                            }),
                        ],
                      );
                    }

                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: SizedBox(
                          width: 64,
                          child: LinearProgressIndicator(
                            color: AppColors().primaryColor,
                          ),
                        ),
                      ),
                    );
                  },
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
                          FutureBuilder(
                            future: OdooService().getAttendanceData(
                              DateFormat("yyyy-MM-dd")
                                  .format(DateTime.now())
                                  .toString(),
                            ),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              debugPrint(snapshot.hasData.toString());
                              return Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  todayAttendanceCard(
                                    "Check In",
                                    snapshot.hasData
                                        ? snapshot.data['check_in']
                                            .toString()
                                            .split(" ")[1]
                                        : "-",
                                    snapshot.hasData ? "Tepat Waktu" : "-",
                                    Iconsax.login_1,
                                  ),
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                  todayAttendanceCard(
                                    "Check Out",
                                    snapshot.hasData
                                        ? snapshot.data['check_out']
                                            .toString()
                                            .split(" ")[1]
                                        : "-",
                                    snapshot.hasData ? "Pulang" : "-",
                                    Iconsax.logout_1,
                                  ),
                                ],
                              );
                            },
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
                                "Senang",
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
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return const AttendanceHistory();
                                      },
                                    ),
                                  );
                                },
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
                          FutureBuilder(
                            future: OdooService().getListAttendanceData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: 5,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(0),
                                  itemBuilder: (context, index) {
                                    return latestAttendanceListItem(
                                        snapshot.data["attendance_list"][index],
                                        context);
                                  },
                                );
                              }

                              return Center(
                                child: SizedBox(
                                  width: 64,
                                  child: LinearProgressIndicator(
                                    color: AppColors().primaryColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 96.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height - 64,
            alignment: AlignmentDirectional.bottomCenter,
            child: buildSwipeButton(context, true, () {}),
          ),
        ],
      ),
    );
  }
}
