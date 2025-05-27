import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DashboardTimesheet extends StatelessWidget {
  const DashboardTimesheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).viewPadding.top + 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Text(
                    "Timesheet",
                    style: createBlackMediumTextStyle(20),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      // bool success = await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const AddEditOvertime(),
                      //   ),
                      // );

                      // if (success) {
                      //   refreshData();
                      // }
                    },
                    child: const Icon(
                      Iconsax.add_square,
                      color: Colors.black54,
                      size: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Iconsax.setting_4,
                      color: Colors.black54,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
