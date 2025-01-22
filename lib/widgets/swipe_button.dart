import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:iconsax/iconsax.dart';

Padding buildSwipeButton(BuildContext context, bool isCheckIn, VoidCallback onSwipe) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SwipeButton(
        borderRadius: BorderRadius.circular(100.0),
        activeThumbColor: isCheckIn ? AppColors().primaryColor : Colors.orange,
        activeTrackColor: isCheckIn ? AppColors().primaryColor : Colors.orange,
        thumb: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Icon(
            Iconsax.arrow_right_1,
            color: isCheckIn ? AppColors().primaryColor : Colors.orange,
          ),
        ),
        height: 64,
        onSwipe: onSwipe,
        child: Text(
          isCheckIn ? "Geser Untuk Check In" : "Geser Untuk Check Out",
          style: createWhiteBoldTextStyle(14),
        ),
      ),
    );
  }