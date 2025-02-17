import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';

InputDecoration customInputBorder(IconData iconData, String labelText) =>
    InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColors().primaryColor,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),
      hintText: "",
      contentPadding: const EdgeInsets.all(16.0),
      label: Text(labelText),
      labelStyle: createGreyThinTextStyle(14),
      suffixIcon: Icon(iconData),
    );
