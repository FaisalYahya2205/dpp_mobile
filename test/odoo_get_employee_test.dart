import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final client = OdooClient(dotenv.get("URL"));
  try {
    final session = await client.authenticate(
        dotenv.get("DATABASE"), "cecep@gmail.com", "a");
    debugPrint("DATA USER => $session");
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
    debugPrint("DATA USER => ${userData[0]}");
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
          'address_id',
          'coach_id',
          'parent_id',
          '__last_update',
          'image_128',
          'image_1920',
          'tz',
          'last_check_in',
          'last_check_out'
        ],
      },
    });
    debugPrint(employeeData.toString());
  } on OdooException catch (e) {
    debugPrint(e.message.split("message: ")[2].split(",")[0]);
    client.close();
  }
  client.close();
}
