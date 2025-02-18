import 'package:dpp_mobile/services/attendance_service.dart';

class AttendanceRepository {
  const AttendanceRepository({
    required this.service,
  });
  final AttendanceService service;

  Future<Map<String, dynamic>> getAttendanceList() async =>
      service.getAttendanceList();
  Future<Map<String, dynamic>> getTodayAttendance(String date) async =>
      service.getTodayAttendance();
}