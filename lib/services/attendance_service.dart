import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/attendance.dart';
import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/models/survey.dart';
import 'package:dpp_mobile/models/survey_post.dart';
import 'package:dpp_mobile/services/employee_service.dart';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:translator/translator.dart';
import 'dart:convert';

/// Service class for handling attendance-related operations with the Odoo server
class AttendanceService {
  final translator = GoogleTranslator();

  /// Fetches the list of attendance records for the current employee
  /// Returns a Map containing:
  /// - success: bool indicating if the operation was successful
  /// - errorMessage: String containing any error message
  /// - data: List<Attendance> containing the attendance records
  Future<Map<String, dynamic>> getAttendanceList() async {
    if (client == null) {
      return _createErrorResponse(
          "Client not initialized", Attendance.emptyList);
    }

    try {
      final employeeResponse = await EmployeeService(translator: translator).getEmployee();
      final employeeData = employeeResponse["data"] as Employee;

      if (employeeData.id == 0) {
        return _createErrorResponse(
            "Employee Access Denied", Attendance.emptyList);
      }

      final data = await client!.callKw({
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

      try {
        final attendancesList = List<Attendance>.from(data.map((item) {
          return Attendance.fromJson(json.encode(item));
        }));

        return {
          "success": true,
          "errorMessage": "",
          "data": attendancesList,
        };
      } catch (e) {
        debugPrint("Error parsing attendance list: ${e.toString()}");
        return _createErrorResponse(
            "Invalid attendance format", Attendance.emptyList);
      }
    } on OdooException catch (e) {
      debugPrint("OdooException in getAttendanceList: ${e.toString()}");
      final message = e.message.split("message: ")[2].split(",")[0];
      final errorMessage =
          await translator.translate(message, from: "en", to: "id");
      return _createErrorResponse(errorMessage.text, Attendance.emptyList);
    } catch (e) {
      debugPrint("Unexpected error in getAttendanceList: ${e.toString()}");
      return _createErrorResponse(
          "An unexpected error occurred", Attendance.emptyList);
    }
  }

  /// Fetches today's attendance record for the current employee
  /// Returns a Map containing:
  /// - success: bool indicating if the operation was successful
  /// - errorMessage: String containing any error message
  /// - data: Attendance containing today's attendance record
  Future<Map<String, dynamic>> getTodayAttendance() async {
    if (client == null) {
      return _createErrorResponse("Client not initialized", Attendance.empty);
    }

    try {
      final employeeResponse = await EmployeeService(translator: translator).getEmployee();
      final employeeData = employeeResponse["data"] as Employee;

      if (employeeData.id == 0) {
        return _createErrorResponse("Employee Access Denied", Attendance.empty);
      }

      final data = await client!.callKw({
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

      if (data.isEmpty) {
        return _createErrorResponse(
            "No attendance record found", Attendance.empty);
      }

      final attendance = Attendance.fromJson(json.encode(data[0]));
      return {
        "success": true,
        "errorMessage": "",
        "data": attendance,
      };
    } on OdooException catch (e) {
      debugPrint("OdooException in getTodayAttendance: ${e.toString()}");
      final message = e.message.split("message: ")[2].split(",")[0];
      final errorMessage =
          await translator.translate(message, from: "en", to: "id");
      return _createErrorResponse(errorMessage.text, Attendance.empty);
    } catch (e) {
      debugPrint("Unexpected error in getTodayAttendance: ${e.toString()}");
      return _createErrorResponse(
          "An unexpected error occurred", Attendance.empty);
    }
  }

  /// Creates an error response with the given message and data
  Map<String, dynamic> _createErrorResponse(String message, dynamic data) {
    return {
      "success": false,
      "errorMessage": message,
      "data": data,
    };
  }

  /// Submits a check-in attendance record
  /// [checkIn] - The check-in time
  /// [latitude] - The latitude of the check-in location
  /// [longitude] - The longitude of the check-in location
  /// [checkInImage] - The base64 encoded check-in image
  /// Returns a Map containing:
  /// - success: bool indicating if the operation was successful
  /// - errorMessage: String containing any error message
  /// - data: int containing the created attendance record ID
  Future<Map<String, dynamic>> postCheckInAttendance(
    String checkIn,
    double latitude,
    double longitude,
    String checkInImage,
  ) async {
    if (client == null) {
      return _createErrorResponse("Client not initialized", 0);
    }

    try {
      final employeeResponse = await EmployeeService(translator: translator).getEmployee();
      final employeeData = employeeResponse["data"] as Employee;

      if (employeeData.id == 0) {
        return _createErrorResponse("Employee Access Denied", 0);
      }

      final checkInAttendance = await client!.callKw({
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

      debugPrint("checkInAttendance: $checkInAttendance");

      return {
        "success": true,
        "errorMessage": "",
        "data": checkInAttendance,
      };
    } on OdooException catch (e) {
      debugPrint("OdooException in postCheckInAttendance: ${e.toString()}");
      final message = e.message.split("message: ")[2].split(",")[0];
      final errorMessage =
          await translator.translate(message, from: "en", to: "id");
      return _createErrorResponse(errorMessage.text, 0);
    } catch (e) {
      debugPrint("Unexpected error in postCheckInAttendance: ${e.toString()}");
      return _createErrorResponse("An unexpected error occurred", 0);
    }
  }

  /// Submits a check-out attendance record
  /// [checkOut] - The check-out time
  /// [latitude] - The latitude of the check-out location
  /// [longitude] - The longitude of the check-out location
  /// [checkOutImage] - The base64 encoded check-out image
  /// [desc] - The description of the check-out
  /// Returns a Map containing:
  /// - success: bool indicating if the operation was successful
  /// - errorMessage: String containing any error message
  /// - data: bool indicating if the check-out was successful
  Future<Map<String, dynamic>> postCheckOutAttendance(
    String checkOut,
    double latitude,
    double longitude,
    String checkOutImage,
    String desc,
  ) async {
    if (client == null) {
      return _createErrorResponse("Client not initialized", false);
    }

    try {
      final employeeResponse = await EmployeeService(translator: translator).getEmployee();
      final employeeData = employeeResponse["data"] as Employee;

      if (employeeData.id == 0) {
        return _createErrorResponse("Employee Access Denied", false);
      }

      final latestAttendance = await getTodayAttendance();
      if (!latestAttendance["success"]) {
        return _createErrorResponse(
            "No attendance record found to check out", false);
      }

      final attendance = latestAttendance["data"] as Attendance;
      if (attendance.id == null) {
        return _createErrorResponse("Invalid attendance record", false);
      }

      await client!.callKw({
        'model': 'hr.attendance',
        'method': 'write',
        'args': [
          [attendance.id],
          {
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

      return {
        "success": true,
        "errorMessage": "",
        "data": true,
      };
    } on OdooException catch (e) {
      debugPrint("OdooException in postCheckOutAttendance: ${e.toString()}");
      final message = e.message.split("message: ")[2].split(",")[0];
      final errorMessage =
          await translator.translate(message, from: "en", to: "id");
      return _createErrorResponse(errorMessage.text, false);
    } catch (e) {
      debugPrint("Unexpected error in postCheckOutAttendance: ${e.toString()}");
      return _createErrorResponse("An unexpected error occurred", false);
    }
  }

  /// Fetches the check-in survey
  /// Returns a Map containing:
  /// - success: bool indicating if the operation was successful
  /// - errorMessage: String containing any error message
  /// - data: Survey containing the check-in survey questions
  Future<Map<String, dynamic>> getCheckInSurvey() async {
    if (client == null) {
      return _createErrorResponse("Client not initialized", Survey.empty);
    }

    try {
      final data = await client!.callKw({
        'model': 'survey.survey',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [
            ["title", "=", "Check In Survey"],
          ],
          'fields': getSurveyFields(),
          'limit': 1,
        },
      });

      if (data.isEmpty) {
        return _createErrorResponse("No survey found", Survey.empty);
      }

      final survey = Survey.fromJson(json.encode(data[0]));
      return {
        "success": true,
        "errorMessage": "",
        "data": survey,
      };
    } on OdooException catch (e) {
      debugPrint("OdooException in getCheckInSurvey: ${e.toString()}");
      final message = e.message.split("message: ")[2].split(",")[0];
      final errorMessage =
          await translator.translate(message, from: "en", to: "id");
      return _createErrorResponse(errorMessage.text, Survey.empty);
    } catch (e) {
      debugPrint("Unexpected error in getCheckInSurvey: ${e.toString()}");
      return _createErrorResponse("An unexpected error occurred", Survey.empty);
    }
  }

  /// Fetches the check-out survey
  /// Returns a Map containing:
  /// - success: bool indicating if the operation was successful
  /// - errorMessage: String containing any error message
  /// - data: Survey containing the check-out survey questions
  Future<Map<String, dynamic>> getCheckOutSurvey() async {
    if (client == null) {
      return _createErrorResponse("Client not initialized", Survey.empty);
    }

    try {
      final data = await client!.callKw({
        'model': 'survey.survey',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [
            ["title", "=", "Check Out Survey"],
          ],
          'fields': getSurveyFields(),
          'limit': 1,
        },
      });

      if (data.isEmpty) {
        return _createErrorResponse("No survey found", Survey.empty);
      }

      final survey = Survey.fromJson(json.encode(data[0]));
      return {
        "success": true,
        "errorMessage": "",
        "data": survey,
      };
    } on OdooException catch (e) {
      debugPrint("OdooException in getCheckOutSurvey: ${e.toString()}");
      final message = e.message.split("message: ")[2].split(",")[0];
      final errorMessage =
          await translator.translate(message, from: "en", to: "id");
      return _createErrorResponse(errorMessage.text, Survey.empty);
    } catch (e) {
      debugPrint("Unexpected error in getCheckOutSurvey: ${e.toString()}");
      return _createErrorResponse("An unexpected error occurred", Survey.empty);
    }
  }

  /// Submits a survey response
  /// Returns a Map containing:
  /// - success: bool indicating if the operation was successful
  /// - errorMessage: String containing any error message
  /// - data: bool indicating if the submission was successful
  Future<Map<String, dynamic>> submitSurvey(SurveyPost surveyPost, int attendanceId) async {
    if (client == null) {
      return _createErrorResponse("Client not initialized", false);
    }

    try {
      await client!.callKw({
        'model': 'survey.user_input',
        'method': 'create',
        'args': [
          {
            'survey_id': surveyPost.surveyId,
            'partner_id': surveyPost.partnerId,
            'user_input_line_ids': surveyPost.userInputLineIds,
          },
        ],
        'kwargs': {},
      });

      return {
        "success": true,
        "errorMessage": "",
        "data": true,
      };
    } on OdooException catch (e) {
      debugPrint("OdooException in submitSurvey: ${e.toString()}");
      final message = e.message.split("message: ")[2].split(",")[0];
      final errorMessage =
          await translator.translate(message, from: "en", to: "id");
      return _createErrorResponse(errorMessage.text, false);
    } catch (e) {
      debugPrint("Unexpected error in submitSurvey: ${e.toString()}");
      return _createErrorResponse("An unexpected error occurred", false);
    }
  }
}
