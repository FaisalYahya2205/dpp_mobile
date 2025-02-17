import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LatestAttendanceError extends StatelessWidget {
  const LatestAttendanceError({super.key});
  // const LatestAttendanceError({super.key, required this.employee});

  // final Employee employee;

  @override
  Widget build(BuildContext context) {
    String? checkInTimeZone, checkOutTimeZone;
    DateTime checkInDateTime =
        DateTime.parse(DateTime.now().toString()).toLocal();
    checkInTimeZone = checkInDateTime.timeZoneName;
    DateTime checkOutDateTime =
        DateTime.parse(DateTime.now().toString()).toLocal();
    checkOutTimeZone = checkOutDateTime.timeZoneName;

    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
            ),
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
                          color: AppColors().primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Icon(
                          Iconsax.login_1,
                          color: AppColors().primaryColor,
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        "Check In",
                        style: createBlackThinTextStyle(14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      "--:--",
                      style: createBlackMediumTextStyle(20),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      checkInTimeZone,
                      style: createBlackMediumTextStyle(20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Terjadi kesalahan",
                    style: createBlackThinTextStyle(14),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
            ),
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
                          color: AppColors().primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Icon(
                          Iconsax.logout_1,
                          color: AppColors().primaryColor,
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        "Check Out",
                        style: createBlackThinTextStyle(14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      "--:--",
                      style: createBlackMediumTextStyle(20),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      checkOutTimeZone,
                      style: createBlackMediumTextStyle(20),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Terjadi kesalahan",
                    style: createBlackThinTextStyle(14),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
