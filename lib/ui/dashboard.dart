import 'package:dpp_mobile/ui/dashboard_timesheet.dart';
import 'package:dpp_mobile/ui/dashboard_home.dart';
import 'package:dpp_mobile/ui/dashboard_overtime.dart';
import 'package:dpp_mobile/ui/dashboard_profile.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/bottom_navigation_bar_item.dart';
import 'package:dpp_mobile/widgets/swipe_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int pageIndex = 0;
  bool isCheckIn = true;
  bool isFit = true;

  final pages = [
    const DashboardHome(),
    const DashboardOvertime(),
    const DashboardTimesheet(),
    const DashboardProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            pages[pageIndex],
            pageIndex == 0
                ? buildSwipeButton(context, isCheckIn, () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            isCheckIn ? "Check In" : "Check Out",
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Text('Lokasimu Saat Ini'),
                                // Image.asset(
                                //   "asset/images/maps.png",
                                //   width: 150,
                                //   height: 75,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Foto',
                                      style: createBlackMediumTextStyle(14),
                                    ),
                                    Text(
                                      'Camera >>',
                                      style: createPrimaryThinTextStyle(14),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8.0)),
                                  ),
                                  child: Text(
                                    "assets-library://asset/asset.PNG?id=CE542E92-B1FF-42DC-BD89-D61BB70EB4BF&ext=PNG",
                                    style: createBlackThinTextStyle(14),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Bagaimana Kondisimu?',
                                      style: createBlackMediumTextStyle(14),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          color: isCheckIn
                                              ? AppColors().primaryColor
                                              : Colors.orange,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8.0)),
                                        ),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "Sehat",
                                          style: createWhiteTextStyle(14),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8.0)),
                                        ),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "Tidak Sehat",
                                          style: createBlackThinTextStyle(14),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Detail Aktivitas Hari Ini",
                                      style: createBlackMediumTextStyle(14),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 100,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          isCheckIn
                                              ? "Check In Success..."
                                              : "Check Out Success...",
                                          style: createWhiteMediumTextStyle(16),
                                        ),
                                        backgroundColor: isCheckIn
                                            ? AppColors().primaryColor
                                            : Colors.orange,
                                      ),
                                    );

                                    setState(() {
                                      isCheckIn = !isCheckIn;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: isCheckIn
                                          ? AppColors().primaryColor
                                          : Colors.orange,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      isCheckIn ? "Check In" : "Check Out",
                                      style: createWhiteTextStyle(14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  })
                : Container(),
          ],
        ),
      ),
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bottomNavItem(
            () => setState(() => pageIndex = 0),
            Iconsax.home_1,
            0,
            pageIndex,
          ),
          bottomNavItem(
            () => setState(() => pageIndex = 1),
            Iconsax.timer_1,
            1,
            pageIndex,
          ),
          bottomNavItem(
            () => setState(() => pageIndex = 2),
            Iconsax.calendar_add,
            2,
            pageIndex,
          ),
          bottomNavItem(
            () => setState(() => pageIndex = 3),
            Iconsax.profile_2user,
            3,
            pageIndex,
          ),
        ],
      ),
    );
  }
}
