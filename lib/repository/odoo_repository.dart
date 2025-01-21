import 'package:dpp_mobile/models/attendance.dart';
import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/services/odoo_service.dart';

class OdooRepository {
  const OdooRepository({
    required this.service,
  });
  final OdooService service;

  Future<Employee> getEmployee() async => service.getEmployee();
  Future<List<Attendance>> getAttendanceList() async =>
      service.getAttendanceList();
  Future<Attendance> getTodayAttendance(String date) async =>
      service.getTodayAttendance();
}
