import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/models/overtime.dart';
import 'package:dpp_mobile/services/employee_service.dart';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:translator/translator.dart';

class OvertimeService {
  final translator = GoogleTranslator();

  Future<Map<String, dynamic>> getOvertimeList(String status) async {
    try {
      Map<String, dynamic> getEmployee = await EmployeeService().getEmployee();
      Employee employeeData = getEmployee["data"];

      if (employeeData.id == 0) {
        return {
          "success": false,
          "errorMessage": "Employee Access Denied",
          "data": Overtime.emptyList,
        };
      }

      debugPrint("GET OVERTIME STATUS => $status");

      List<dynamic> data = await client!.callKw({
        'model': 'hr.overtime',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [
            ["employee_id", "=", employeeData.id],
            ["state", "=", status],
          ],
          'fields': getOvertimeFields(),
        },
      });

      List<Overtime>? overtimesList;

      try {
        for (var overtime in data) {
          if (overtime['overtime_type_id'] != false) {
            List<dynamic> overtimeType = await client!.callKw({
              'model': 'overtime.type',
              'method': 'search_read',
              'args': [],
              'kwargs': {
                'context': {'bin_size': true},
                'domain': [
                  ['id', '=', overtime['overtime_type_id'][0]],
                ],
                'fields': ['id', 'name'],
              },
            });

            overtime['overtime_type_id'] = overtimeType[0];
          }
        }
        overtimesList = List<Overtime>.from(data.map((item) {
          return Overtime.fromMap(item);
        }));
      } catch (e) {
        return {
          "success": false,
          "errorMessage": "Format Invalid",
          "data": Overtime.emptyList,
        };
      }

      return {
        "success": true,
        "errorMessage": "",
        "data": overtimesList,
      };
    } on OdooException catch (e) {
      debugPrint(e.toString());
      String message = e.message.split("message: ")[2].split(",")[0];
      Translation errorMessage =
          await translator.translate(message, from: "en", to: "id");
      return {
        "success": false,
        "errorMessage": errorMessage.text,
        "data": Overtime.emptyList,
      };
    }
  }

  Future<Map<String, dynamic>> postOvertimeRequest(
    String dateFrom,
    String dateTo,
    String attchdCopy,
    String desc,
  ) async {
    try {
      Map<String, dynamic> getEmployee = await EmployeeService().getEmployee();
      Employee employeeData = getEmployee["data"];

      if (employeeData.id == 0) {
        return {
          "success": false,
          "errorMessage": "Employee Access Denied",
          "data": 0,
        };
      }

      final requestResponse = await client!.callKw({
        'model': 'hr.overtime',
        'method': 'create',
        'args': [
          {
            'employee_id': employeeData.id,
            'date_from': dateFrom,
            'date_to': dateTo,
            'attchd_copy': attchdCopy,
            'desc': desc,
          },
        ],
        'kwargs': {},
      });

      return {
        "success": true,
        "errorMessage": "",
        "data": requestResponse,
      };
    } on OdooException catch (e) {
      debugPrint(e.toString());
      String message = e.message.split("message: ")[2].split(",")[0];
      Translation errorMessage =
          await translator.translate(message, from: "en", to: "id");
      return {
        "success": false,
        "errorMessage": errorMessage.text,
        "data": 0,
      };
    }
  }
}
