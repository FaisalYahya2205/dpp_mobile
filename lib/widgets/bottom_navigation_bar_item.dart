import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

Widget bottomNavItem(
  GestureTapCallback onTap,
  IconData icon,
  int pageIndex,
  int currentPageIndex,
) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0, 0.1),
            colors: [
              pageIndex == currentPageIndex
                  ? AppColors().primaryColor.shade50.withAlpha(100)
                  : Colors.white,
              Colors.white,
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: pageIndex == currentPageIndex
              ? AppColors().primaryColor
              : pageIndex == 4
                  ? Colors.red
                  : Colors.grey,
        ),
      ),
    );
