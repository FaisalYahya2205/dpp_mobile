import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/models/overtime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:translator/translator.dart';

void main() async {
  final translator = GoogleTranslator();
  await dotenv.load(fileName: ".env");
  final client = OdooClient(dotenv.get("URL"));
  try {
    await client.authenticate(dotenv.get("DATABASE"), "cecep@gmail.com", "a");

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

    // final overtimeCreateProcess = await client.callKw({
    //   'model': 'hr.overtime',
    //   'method': 'create',
    //   'args': [
    //     {
    //       'employee_id': employeeData.id,
    //       'date_from': "2025-12-02 23:40:00",
    //       'date_to': "2025-12-02 23:45:00",
    //       'attchd_copy': '',
    //       'desc': "test example"
    //     },
    //   ],
    //   'kwargs': {},
    // });
    // debugPrint("CREATE OVERTIME => ${overtimeCreateProcess.toString()}");

    final overtimeUpdateProcess = await client.callKw({
      'model': 'hr.overtime',
      'method': 'request_validation',
      'args': [
        [89505]
      ],
      'kwargs': {},
    });
    debugPrint("UPDATE OVERTIME => ${overtimeUpdateProcess.toString()}");

    // List<dynamic> overtimeType = await client.callKw({
    //   'model': 'overtime.type',
    //   'method': 'search_read',
    //   'args': [],
    //   'kwargs': {
    //     'context': {'bin_size': true},
    //     'fields': ['name'],
    //   },
    // });

    // debugPrint("OVERTIME TYPE => ${overtimeType.toString()}");

    List<dynamic> data = await client.callKw({
      'model': 'hr.overtime',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ["employee_id", "=", employeeData.id],
          ["state", "=", "draft"],
        ],
        'fields': getOvertimeFields(),
      },
    });

    for (var overtime in data) {
      if (overtime['overtime_type_id'] != false) {
        List<dynamic> overtimeType = await client.callKw({
          'model': 'overtime.type',
          'method': 'search_read',
          'args': [],
          'kwargs': {
            'context': {'bin_size': true},
            'domain': [
              ['id', '=', overtime['overtime_type_id'][0]],
            ],
            'fields': ['name'],
          },
        });

        overtime['overtime_type_id'] = overtimeType[0];
      }
    }

    List<Overtime> overtimeList = List<Overtime>.from(
      data.map((item) => Overtime.fromMap(item)),
    );

    debugPrint(overtimeList.toString());
  } on OdooException catch (e) {
    String message = e.message.split("message: ")[2].split(",")[0];
    Translation result =
        await translator.translate(message, from: "en", to: "id");
    debugPrint(result.text);
  }
}
