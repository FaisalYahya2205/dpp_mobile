import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(
                height: 48,
                width: 48,
                child: CircularProgressIndicator(
                  color: AppColors().primaryColor,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: createBlackTextStyle(24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                message,
                style: createGreyThinTextStyle(14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
