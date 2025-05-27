import 'package:dpp_mobile/models/overtime.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DashboardHomeOvertimeSuccess extends StatelessWidget {
  const DashboardHomeOvertimeSuccess({super.key, required this.overtimes});

  final List<Overtime> overtimes;

  @override
  Widget build(BuildContext context) {
    if (overtimes.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Text(
            "Belum ada daftar pengajuan...",
            style: createBlackThinTextStyle(14),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: overtimes.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        DateTime dateTimeFrom =
            DateTime.parse("${overtimes[index].dateFrom}Z").toLocal();
        DateTime dateTimeTo =
            DateTime.parse("${overtimes[index].dateTo}Z").toLocal();
        String timeZone = dateTimeFrom.timeZoneName;

        String startDate = DateFormat.yMMMd().format(dateTimeFrom);
        String startHour = dateTimeFrom.hour.toString().length == 1
            ? "0${dateTimeFrom.hour}"
            : dateTimeFrom.hour.toString();
        String startMinutes = dateTimeFrom.minute.toString().length == 1
            ? "0${dateTimeFrom.minute}"
            : dateTimeFrom.minute.toString();
        String startTime = "$startHour:$startMinutes";

        String endDate = DateFormat.yMMMd().format(dateTimeTo);
        String endHour = dateTimeTo.hour.toString().length == 1
            ? "0${dateTimeTo.hour}"
            : dateTimeTo.hour.toString();
        String endMinutes = dateTimeTo.minute.toString().length == 1
            ? "0${dateTimeTo.minute}"
            : dateTimeTo.minute.toString();
        String endTime = "$endHour:$endMinutes";

        String showDate =
            startDate == endDate ? startDate : "$startDate - $endDate";

        return GestureDetector(
          onTap: () {
            debugPrint("OVERTIME DETAIL => ${overtimes[index].toString()}");
            context.push(
              "/detail_overtime",
              extra: overtimes[index],
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              "Tanggal",
                              style: createBlackThinTextStyle(12),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              showDate,
                              style: createBlackMediumTextStyle(12),
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: overtimes[index].state! == "approved"
                              ? Colors.green.shade100
                              : overtimes[index].state! == "f_approve"
                                  ? Colors.yellow.shade100
                                  : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          overtimes[index].state! == "f_approve"
                              ? "Waiting"
                              : "${overtimes[index].state![0].toUpperCase()}${overtimes[index].state!.substring(1)}",
                          style: overtimes[index].state! == "approved"
                              ? createGreenMediumTextStyle(12)
                              : overtimes[index].state! == "f_approve"
                                  ? createYellowMediumTextStyle(12)
                                  : createGreyMediumTextStyle(12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Start Time",
                                        style: createBlackThinTextStyle(12),
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        "$startTime $timeZone",
                                        style: createBlackMediumTextStyle(14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "End Time",
                                        style: createBlackThinTextStyle(12),
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        "$endTime $timeZone",
                                        style: createBlackMediumTextStyle(14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Duration",
                                        style: createBlackThinTextStyle(12),
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        overtimes[index]
                                            .daysNoTmp!
                                            .toStringAsFixed(2),
                                        style: createBlackMediumTextStyle(14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                overtimes[index].nextReview != null
                    ? Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          overtimes[index].nextReview!,
                          style: createGreyMediumTextStyle(12),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox(
                        height: 8.0,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
