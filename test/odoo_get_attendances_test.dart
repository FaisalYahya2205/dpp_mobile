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
        'fields': ['id'],
        'limit': 80,
      },
    });
    debugPrint("DATA USER => " + userData[0].toString());
    final employeeData = await client.callKw({
      'model': 'hr.employee',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ["user_id", "=", userData[0]["id"]]
        ],
        'fields': [
          'id',
          'name',
          'nrp',
          'job_id',
          'job_title',
          'work_email',
          'work_phone',
          '__last_update',
          'image_128',
          'tz'
        ],
      },
    });
    debugPrint(employeeData.toString());
    final attendanceList = await client.callKw({
      'model': 'hr.attendance',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ["employee_id", "=", employeeData[0]["id"]],
          ["check_out", "like", "%2025-01-09%"],
        ],
        'fields': [
          'employee_id',
          'check_in',
          'geo_access_check_in',
          'ismobile_check_in',
          'geo_check_in',
          'map_url_check_in',
          'check_in_image',
          'check_out',
          'geo_access_check_out',
          'ismobile_check_out',
          'geo_check_out',
          'map_url_check_out',
          'check_out_image',
        ],
        'limit': 1,
      },
    });
    debugPrint(attendanceList.toString());
  } on OdooException catch (e) {
    debugPrint(e.message);
    client.close();
  }
  client.close();
}
