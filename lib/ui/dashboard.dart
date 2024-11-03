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
