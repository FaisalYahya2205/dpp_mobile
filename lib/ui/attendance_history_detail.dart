import 'package:dpp_mobile/utils/constants/profile_sample.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AttendaceHistoryDetail extends StatefulWidget {
  const AttendaceHistoryDetail({super.key, required this.attendanceItem});

  final Map<String, dynamic> attendanceItem;

  @override
  State<AttendaceHistoryDetail> createState() => _AttendaceHistoryDetailState();
}

class _AttendaceHistoryDetailState extends State<AttendaceHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Detail Kehadiran",
          style: createBlackTextStyle(18),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                radius: 60,
                child: const Icon(
                  Iconsax.image,
                  color: Colors.black54,
                  size: 60,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                profileSample["name"],
                style: createBlackMediumTextStyle(20),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Fullstack Developer",
                style: createBlackThinTextStyle(16),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                widget.attendanceItem["date"],
                style: createBlackMediumTextStyle(20),
              ),
              const SizedBox(
                height: 32.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: AppColors().primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Icon(
                              Iconsax.login_1,
                              color: AppColors().primaryColor,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Check In",
                                style: createBlackBoldTextStyle(14),
                              ),
                              Text(
                                widget.attendanceItem["time"],
                                style: createBlackThinTextStyle(14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: AppColors().primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Icon(
                              Iconsax.login_1,
                              color: AppColors().primaryColor,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Check Out",
                                style: createBlackBoldTextStyle(14),
                              ),
                              Text(
                                "06:16 pm",
                                style: createBlackThinTextStyle(14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kesehatan",
                      style: createBlackBoldTextStyle(14),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      widget.attendanceItem["check_in_status"],
                      style: createBlackBoldTextStyle(14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Indeks Kebahagiaan",
                      style: createBlackBoldTextStyle(14),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      widget.attendanceItem["check_out_status"],
                      style: createBlackBoldTextStyle(14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lokasi",
                      style: createBlackBoldTextStyle(14),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Buka Maps",
                      style: createPrimaryMediumTextStyle(14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Detail Aktivitas Hari Ini",
                      style: createBlackBoldTextStyle(14),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Check In",
                      style: createBlackMediumTextStyle(14),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      widget.attendanceItem["detail_activity"],
                      style: createBlackThinTextStyle(14),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "Check Out",
                      style: createBlackMediumTextStyle(14),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      widget.attendanceItem["detail_activity"],
                      style: createBlackThinTextStyle(14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
