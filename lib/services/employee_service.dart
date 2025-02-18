import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:translator/translator.dart';

class EmployeeService {
  final translator = GoogleTranslator();

  Future<Map<String, dynamic>> getEmployee() async {
    try {
      List<dynamic> data = await client!.callKw({
        "model": "hr.employee",
        "method": "search_read",
        "args": [],
        "kwargs": {
          "context": {"bin_size": true},
          "domain": [
            ["user_id", "=", localSession!.first["user_id"]]
          ],
          "fields": getEmployeeFields(),
        },
      });

      debugPrint("GET EMPLOYEE => $data");

      if (data.isEmpty) {
        return {
          "success": false,
          "errorMessage": "Not Found",
          "data": Employee.empty,
        };
      }

      Employee employeeData = Employee.empty;
      try {
        employeeData = Employee.fromMap(data[0]);
      } catch (e) {
        return {
          "success": false,
          "errorMessage": "Format Invalid",
          "data": Employee.empty,
        };
      }
      return {
        "success": true,
        "errorMessage": "",
        "data": employeeData,
      };
    } on OdooException catch (e) {
      debugPrint(e.toString());
      String message = e.message.split("message: ")[2].split(",")[0];
      Translation errorMessage =
          await translator.translate(message, from: "en", to: "id");
      return {
        "success": false,
        "errorMessage": errorMessage.text,
        "data": Employee.empty,
      };
    }
  }
}
