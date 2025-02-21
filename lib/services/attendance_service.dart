import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/attendance.dart';
import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/services/employee_service.dart';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:translator/translator.dart';

class AttendanceService {
  final translator = GoogleTranslator();

  Future<Map<String, dynamic>> getAttendanceList() async {
    try {
      Map<String, dynamic> getEmployee = await EmployeeService().getEmployee();
      Employee employeeData = getEmployee["data"];

      if (employeeData.id == 0) {
        return {
          "success": false,
          "errorMessage": "Employee Access Denied",
          "data": Attendance.emptyList,
        };
      }

      List<dynamic> data = await client!.callKw({
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

      List<Attendance>? attendancesList;

      try {
        attendancesList = List<Attendance>.from(data.map((item) {
          return Attendance.fromMap(item);
        }));
      } catch (e) {
        return {
          "success": false,
          "errorMessage": "Format Invalid",
          "data": Attendance.emptyList,
        };
      }

      return {
        "success": true,
        "errorMessage": "",
        "data": attendancesList,
      };
    } on OdooException catch (e) {
      debugPrint(e.toString());
      String message = e.message.split("message: ")[2].split(",")[0];
      Translation errorMessage =
          await translator.translate(message, from: "en", to: "id");
      return {
        "success": false,
        "errorMessage": errorMessage.text,
        "data": Attendance.emptyList,
      };
    }
  }

  Future<Map<String, dynamic>> getTodayAttendance() async {
    try {
      Map<String, dynamic> getEmployee = await EmployeeService().getEmployee();
      Employee employeeData = getEmployee["data"];

      if (employeeData.id == 0) {
        return {
          "success": false,
          "errorMessage": "Employee Access Denied",
          "data": Attendance.empty,
        };
      }

      List<dynamic> data = await client!.callKw({
        'model': 'hr.attendance',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [
            ["employee_id", "=", employeeData.id],
            ["check_out", "=", false],
          ],
          'fields': getAttendanceFields(),
          'limit': 1,
        },
      });
      Attendance attendance = Attendance.fromMap(data[0]);
      return {
        "success": true,
        "errorMessage": "",
        "data": attendance,
      };
    } on OdooException catch (e) {
      debugPrint(e.toString());
      String message = e.message.split("message: ")[2].split(",")[0];
      Translation errorMessage =
          await translator.translate(message, from: "en", to: "id");
      return {
        "success": false,
        "errorMessage": errorMessage.text,
        "data": Attendance.empty,
      };
    }
  }

  Future<Map<String, dynamic>> postCheckInAttendance(
    String checkIn,
    double latitude,
    double longitude,
    String checkInImage,
  ) async {
    try {
      Map<String, dynamic> getEmployee = await EmployeeService().getEmployee();
      Employee employeeData = getEmployee["data"];

      int checkInAttendance = await client!.callKw({
        'model': 'hr.attendance',
        'method': 'create',
        'args': [
          {
            'employee_id': employeeData.id,
            'check_in': checkIn,
            'geo_check_in': "$latitude $longitude",
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
                "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
            'check_in_image': checkInImage,
          },
        ],
        'kwargs': {},
      });
      // debugPrint("POST CHECK IN ATTENDANCE => $checkInAttendance");
      return {
        "success": true,
        "errorMessage": "",
        "data": checkInAttendance,
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

  Future<Map<String, dynamic>> postCheckOutAttendance(
    String checkOut,
    double latitude,
    double longitude,
    String checkOutImage,
    String desc,
  ) async {
    try {
      Map<String, dynamic> getEmployee = await EmployeeService().getEmployee();
      Employee employeeData = getEmployee["data"];

      Map<String, dynamic> latestAttendance = await getTodayAttendance();
      Attendance attendance = latestAttendance["data"];

      bool checkOutAttendance = await client!.callKw({
        'model': 'hr.attendance',
        'method': 'write',
        'args': [
          attendance.id,
          {
            'employee_id': employeeData.id,
            'check_out': checkOut,
            'geo_check_out': "$latitude $longitude",
            'ismobile_check_out': true,
            'geo_access_check_out': '''
              <h5>
                <div>
                  <div>
                      <i class="fa fa-check-square-o token-fa-3x" style="color:orange"></i>
                  </div>
                </div>
              </h5>''',
            'map_url_check_out':
                "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
            'check_out_image': checkOutImage,
            'desc': desc,
          },
        ],
        'kwargs': {},
      });
      // debugPrint("POST CHECK OUT ATTENDANCE => $checkOutAttendance");
      return {
        "success": true,
        "errorMessage": "",
        "data": checkOutAttendance,
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
