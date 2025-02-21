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

  Future<Map<String, dynamic>> checkIn(
    String checkIn,
    double latitude,
    double longitude,
    String checkInImage,
  ) async =>
      service.postCheckInAttendance(
        checkIn,
        latitude,
        longitude,
        checkInImage,
      );

  Future<Map<String, dynamic>> checkOut(
    String checkOut,
    double latitude,
    double longitude,
    String checkOutImage,
    String desc,
  ) async =>
      service.postCheckOutAttendance(
        checkOut,
        latitude,
        longitude,
        checkOutImage,
        desc,
      );
}
