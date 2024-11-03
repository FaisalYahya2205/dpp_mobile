import 'package:dpp_mobile/utils/constants/profile_sample.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DashboardProfile extends StatelessWidget {
  const DashboardProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top,
              ),
              const SizedBox(
                height: 48,
              ),
              Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors().primaryColor.shade50.withOpacity(0.25),
                ),
                child: Icon(
                  Iconsax.profile_2user,
                  size: 40,
                  color: AppColors().primaryColor,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                profileSample["name"],
                style: createBlackTextStyle(20),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Fullstack Developer",
                style: createBlackThinTextStyle(14),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors().primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Ubah Profile",
                    style: createWhiteBoldTextStyle(14),
                  ),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              profileItem(
                Iconsax.user_tag,
                "Nama",
                profileSample["name"].toString(),
              ),
              const SizedBox(
                height: 16,
              ),
              profileItem(
                Iconsax.call,
                "Work Mobile",
                profileSample["workMobile"].toString(),
              ),
              const SizedBox(
                height: 16,
              ),
              profileItem(
                Iconsax.call_calling,
                "Work Phone",
                profileSample["workPhone"].toString(),
              ),
              const SizedBox(
                height: 16,
              ),
              profileItem(
                Iconsax.sms,
                "Work Email",
                profileSample["workEmail"].toString(),
              ),
              const SizedBox(
                height: 16,
              ),
              profileItem(
                Iconsax.building,
                "Work Location",
                profileSample["workLocation"].toString(),
              ),
              const SizedBox(
                height: 16,
              ),
              profileItem(
                Iconsax.user_octagon,
                "Manager Coach",
                profileSample["managerCoach"].toString(),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
