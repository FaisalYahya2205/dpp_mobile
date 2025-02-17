              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 16.0,
              //     vertical: 16.0,
              //   ),
              //   child: FutureBuilder(
              //     future: CalendarService().generateDateList(),
              //     builder:
              //         (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              //       if (snapshot.hasData) {
              //         int currentDay = DateTime.now().day;
              //         return Flex(
              //           direction: Axis.horizontal,
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             for (Map<String, dynamic> dateItem in snapshot.data)
              //               calendarItem(dateItem, currentDay, () {}),
              //           ],
              //         );
              //       }
              //       return const DashboardHomeLoading();
              //     },
              //   ),
              // ),

class CalendarService {
  Future<List<Map<String, dynamic>>> generateDateList() async {
    List<Map<String, dynamic>> tempListDates = [];
    for (var i = 3; i >= 0; i--) {
      DateTime dateSubtract = DateTime.now().subtract(Duration(days: i));
      String dayName = "";
      switch (dateSubtract.weekday) {
        case 1:
          dayName = "Senin";
          break;
        case 2:
          dayName = "Selasa";
          break;
        case 3:
          dayName = "Rabu";
          break;
        case 4:
          dayName = "Kamis";
          break;
        case 5:
          dayName = "Jum'at";
          break;
        case 6:
          dayName = "Sabtu";
          break;
        case 7:
          dayName = "Minggu";
          break;
        default:
          dayName = "";
      }
      var dateObject = {
        "day": dateSubtract.day,
        "dayName": dayName,
        "dateTime": dateSubtract.toIso8601String().split("T")[0],
      };
      tempListDates.add(dateObject);
    }
    return tempListDates;
  }
}
