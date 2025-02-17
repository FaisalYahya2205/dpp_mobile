import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final client = OdooClient(dotenv.get("URL"));
  try {
    final auth = await client.authenticate(
        dotenv.get("DATABASE"), "cecep@gmail.com", "a");
    debugPrint("AUTHENTICATION => ${auth.toString()}");
    final userData = await client.callKw({
      'model': 'res.users',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ["email", "=", "cecep@gmail.com"]
        ],
        'fields': ['id'],
        'limit': 80,
      },
    });
    debugPrint("USER DATA => ${userData.toString()}");
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
          'image_1920',
          'tz',
        ],
      },
    });
    debugPrint("EMPLOYEE DATA => ${employeeData.toString()}");
    final checkInProcess = await client.callKw({
      'model': 'hr.attendance',
      'method': 'create',
      'args': [
        {
          'employee_id': employeeData[0]['id'],
          'check_in': DateTime.now().toUtc().toString().split(".")[0],
          'geo_check_in': "-6.916226 107.704237",
          'ismobile_check_in': true,
          'geo_access_check_in': '''
            <h5>
              <div>
                <div>
                    <i class="fa fa-check-square-o token-fa-3x" style="color:orange"></i>
                </div>
              </div>
            </h5>''',
          'map_url_check_in':
              "https://www.google.com/maps/search/?api=1&query=-6.916226,107.704237",
          'check_in_image': "",
        },
      ],
      'kwargs': {},
    });
    debugPrint("CHECK IN PROCESS => ${checkInProcess.toString()}");
  } on OdooException catch (e) {
    debugPrint(e.message);
    client.close();
  }
  client.close();
}
