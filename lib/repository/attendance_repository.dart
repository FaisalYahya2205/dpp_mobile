import 'package:dpp_mobile/models/attendance.dart';
import 'package:dpp_mobile/models/survey.dart';
import 'package:dpp_mobile/models/survey_post.dart';
import 'package:dpp_mobile/services/attendance_service.dart';

/// Repository class for handling attendance-related operations
class AttendanceRepository {
  const AttendanceRepository({
    required this.service,
  });

  final AttendanceService service;

  /// Fetches the list of attendance records
  /// Returns a Map containing:
  /// - success: bool indicating if the operation was successful
  /// - errorMessage: String containing any error message
  /// - data: List<Attendance> containing the attendance records
  Future<Map<String, dynamic>> getAttendanceList() async {
    try {
      return await service.getAttendanceList();
    } catch (e) {
      return {
        "success": false,
        "errorMessage": "Failed to fetch attendance list",
        "data": Attendance.emptyList,
      };
    }
  }

  /// Fetches today's attendance record
  /// Returns a Map containing:
  /// - success: bool indicating if the operation was successful
  /// - errorMessage: String containing any error message
  /// - data: Attendance containing today's attendance record
  Future<Map<String, dynamic>> getTodayAttendance(String date) async {
    try {
      return await service.getTodayAttendance();
    } catch (e) {
      return {
        "success": false,
        "errorMessage": "Failed to fetch today's attendance",
        "data": Attendance.empty,
      };
    }
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
  Future<Map<String, dynamic>> checkIn(
    String checkIn,
    double latitude,
    double longitude,
    String checkInImage,
  ) async {
    try {
      return await service.postCheckInAttendance(
        checkIn,
        latitude,
        longitude,
        checkInImage,
      );
    } catch (e) {
      return {
        "success": false,
        "errorMessage": "Failed to submit check-in",
        "data": 0,
      };
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
  Future<Map<String, dynamic>> checkOut(
    String checkOut,
    double latitude,
    double longitude,
    String checkOutImage,
    String desc,
  ) async {
    try {
      return await service.postCheckOutAttendance(
        checkOut,
        latitude,
        longitude,
        checkOutImage,
        desc,
      );
    } catch (e) {
      return {
        "success": false,
        "errorMessage": "Failed to submit check-out",
        "data": false,
      };
    }
  }

  /// Fetches the check-in survey
  /// Returns a Map containing:
  /// - success: bool indicating if the operation was successful
  /// - errorMessage: String containing any error message
  /// - data: Survey containing the check-in survey questions
  Future<Map<String, dynamic>> getCheckInSurvey() async {
    try {
      return await service.getCheckInSurvey();
    } catch (e) {
      return {
        "success": false,
        "errorMessage": "Failed to fetch check-in survey",
        "data": Survey.empty,
      };
    }
  }

  /// Fetches the check-out survey
  /// Returns a Map containing:
  /// - success: bool indicating if the operation was successful
  /// - errorMessage: String containing any error message
  /// - data: Survey containing the check-out survey questions
  Future<Map<String, dynamic>> getCheckOutSurvey() async {
    try {
      return await service.getCheckOutSurvey();
    } catch (e) {
      return {
        "success": false,
        "errorMessage": "Failed to fetch check-out survey",
        "data": Survey.empty,
      };
    }
  }

  /// Submits a survey response
  /// Returns a Map containing:
  /// - success: bool indicating if the operation was successful
  /// - errorMessage: String containing any error message
  /// - data: bool indicating if the submission was successful
  Future<Map<String, dynamic>> submitSurvey(SurveyPost surveyPost, int attendanceId) async {
    try {
      return await service.submitSurvey(surveyPost, attendanceId);
    } catch (e) {
      return {
        "success": false,
        "errorMessage": "Failed to submit survey",
        "data": false,
      };
    }
  }
}
