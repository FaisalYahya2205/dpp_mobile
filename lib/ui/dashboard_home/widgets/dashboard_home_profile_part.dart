import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';

class ProfilePart extends StatelessWidget {
  const ProfilePart({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
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
              color: AppColors().primaryColor.shade50.withAlpha(50),
            ),
            child: Image.network(
              "https://dpp.tbdigitalindo.co.id/web/image?model=hr.employee&id=${employee.id!}&field=image_128",
              headers: {
                'Cookie': 'session_id=${localSession!.first["id"]}',
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
                employee.name!,
                style: createBlackTextStyle(20),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                employee.job_title!,
                style: createBlackThinTextStyle(14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
