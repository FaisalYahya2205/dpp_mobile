import 'package:dpp_mobile/utils/constants/attendance_list.dart';
import 'package:dpp_mobile/utils/constants/profile_sample.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/attendance_latest_list_item.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AttendanceHistory extends StatefulWidget {
  const AttendanceHistory({super.key, required this.attendanceList});

  final List<Map<String, dynamic>> attendanceList;

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
  List<Map<String, dynamic>> copyAttendanceListSamples = [
    ...attendanceListSamples
  ];

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
          profileSample["name"],
          style: createBlackTextStyle(18),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                itemCount: widget.attendanceList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return latestAttendanceListItem(
                      widget.attendanceList[index], context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
