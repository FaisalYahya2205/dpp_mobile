import 'dart:convert';

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
        dotenv.get("DATABASE"), "cecep@gmail.com", "a");

    final userData = await client.callKw({
      'model': 'res.users',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ["email", "=", "cecep@gmail.com"]
        ],
        'fields': ['id', 'partner_id'],
        'limit': 80,
      },
    });

    debugPrint(userData.toString());

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
    Employee employeeData = Employee.fromJson(json.encode(employee[0]));

    final data = await client.callKw({
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
        'limit': 1
      },
    });

    debugPrint(data.toString());
    
    List<Attendance> attendancesList = List<Attendance>.from(
      data.map((item) => Attendance.fromJson(json.encode(item))),
    );
    debugPrint(attendancesList.toString());
  } catch (e) {
    debugPrint(e.toString());
  }
}
