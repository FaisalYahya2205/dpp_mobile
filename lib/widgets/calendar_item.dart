import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';

Widget calendarItem(
  Map<String, dynamic> calendarItem,
  int calendarSelected,
  VoidCallback onTapAction,
) =>
    Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: onTapAction,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: calendarItem["day"] == calendarSelected
                ? AppColors().primaryColor
                : Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  calendarItem["day"].toString(),
                  style: calendarItem["day"] == calendarSelected
                      ? createWhiteThinTextStyle(20)
                      : createBlackMediumTextStyle(20),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  calendarItem["dayName"].toString(),
                  style: calendarItem["day"] == calendarSelected
                      ? createWhiteThinTextStyle(14)
                      : createBlackThinTextStyle(14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
