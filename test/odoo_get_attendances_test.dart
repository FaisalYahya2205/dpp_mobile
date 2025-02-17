import 'package:dpp_mobile/models/attendance.dart';
import 'package:dpp_mobile/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final client = OdooClient(dotenv.get("URL"));
  try {
    await client.authenticate(
        dotenv.get("DATABASE"), "andiade52@gmail.com", "a");

    final userData = await client.callKw({
      'model': 'res.users',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ["email", "=", "andiade52@gmail.com"]
        ],
        'fields': ['id', 'partner_id'],
        'limit': 80,
      },
    });

    List<dynamic> employee = await client.callKw({
      "model": "hr.employee",
      "method": "search_read",
      "args": [],
      "kwargs": {
        "context": {"bin_size": true},
        "domain": [
          ["user_id", "=", userData[0]['id']]
        ],
        "fields": getEmployeeFields(),
      },
    });
    Employee employeeData = Employee.fromMap(employee[0]);

    List<dynamic> data = await client.callKw({
      'model': 'hr.attendance',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ["employee_id", "=", employeeData.id],
          ["check_in", "!=", false],
          ["check_out", "!=", false],
        ],
        'fields': getAttendanceFields(),
      },
    });
    List<Attendance> attendancesList = List<Attendance>.from(
      data.map((item) => Attendance.fromMap(item)),
    );
    debugPrint(attendancesList.toString());
  } catch (e) {
    debugPrint(e.toString());
  }
}
