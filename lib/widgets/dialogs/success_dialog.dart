import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key, required this.title, required this.message});

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
              const Icon(
                Iconsax.tick_circle,
                color: Colors.green,
                size: 48,
              ),
              const SizedBox(
                height: 24,
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
