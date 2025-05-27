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
  const CalendarService();

  static const _daysInIndonesian = {
    1: 'Senin',
    2: 'Selasa',
    3: 'Rabu',
    4: 'Kamis',
    5: 'Jum\'at',
    6: 'Sabtu',
    7: 'Minggu',
  };

  static const _daysToGenerate = 4;

  Future<List<Map<String, dynamic>>> generateDateList() async {
    final tempListDates = <Map<String, dynamic>>[];
    final now = DateTime.now();

    for (var i = _daysToGenerate - 1; i >= 0; i--) {
      final dateSubtract = now.subtract(Duration(days: i));
      final dayName = _daysInIndonesian[dateSubtract.weekday] ?? '';
      
      final dateObject = {
        'day': dateSubtract.day,
        'dayName': dayName,
        'dateTime': dateSubtract.toIso8601String().split('T')[0],
      };
      
      tempListDates.add(dateObject);
    }
    
    return tempListDates;
  }
}
