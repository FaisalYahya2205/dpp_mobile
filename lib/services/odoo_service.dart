import "package:dpp_mobile/main.dart";
import "package:dpp_mobile/models/attendance.dart";
import "package:dpp_mobile/models/employee.dart";
import "package:dpp_mobile/models/result_error.dart";
import "package:dpp_mobile/models/session.dart";
import "package:dpp_mobile/models/user.dart";
import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:geolocator/geolocator.dart";
import "package:odoo_rpc/odoo_rpc.dart";

class OdooService {
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    debugPrint("LOCATION SERVICE IS ENABLED");

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<Map<String, dynamic>>> generateDateList() async {
    List<Map<String, dynamic>> tempListDates = [];
    for (var i = 3; i >= 0; i--) {
      DateTime dateSubtract = DateTime.now().subtract(Duration(days: i));
      String dayName = "";
      switch (dateSubtract.weekday) {
        case 1:
          dayName = "Senin";
          break;
        case 2:
          dayName = "Selasa";
          break;
        case 3:
          dayName = "Rabu";
          break;
        case 4:
          dayName = "Kamis";
          break;
        case 5:
          dayName = "Jum'at";
          break;
        case 6:
          dayName = "Sabtu";
          break;
        case 7:
          dayName = "Minggu";
          break;
        default:
          dayName = "";
      }
      var dateObject = {
        "day": dateSubtract.day,
        "dayName": dayName,
        "dateTime": dateSubtract.toIso8601String().split("T")[0],
      };
      tempListDates.add(dateObject);
    }
    return tempListDates;
  }

  Future<bool> authentication(String username, String password) async {
    try {
      OdooSession odooSession = await client!
          .authenticate(dotenv.get("DATABASE"), username, password);
      final userData = await client!.callKw({
        "model": "res.users",
        "method": "search_read",
        "args": [],
        "kwargs": {
          "context": {"bin_size": true},
          "domain": [
            ["email", "=", username]
          ],
          "fields": getUserFields(),
        },
      });

      await databaseHelper!.truncateQuery("session");
      await databaseHelper!.insertQuery(
        "session",
        Session(
          id: odooSession.id,
          user_id: odooSession.userId,
          partner_id: userData[0]["partner_id"][0],
          user_login: odooSession.userLogin,
          user_name: odooSession.userName,
          password: password,
        ).toMap(),
      );
      return true;
    } on OdooException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  Future<Employee> getEmployee() async {
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
      Employee employeeData = Employee.empty;
      try {
        employeeData = Employee.fromMap(data[0]);
      } catch (e) {
        debugPrint("GET EMPLOYEE ERROR => ${e.toString()}");
      }
      return employeeData;
    } catch (e) {
      debugPrint("GET EMPLOYEE ERROR => ${e.toString()}");
      throw ErrorEmptyResponse();
    }
  }

  Future<List<Attendance>> getAttendanceList() async {
    try {
      Employee employeeData = await getEmployee();
      debugPrint("GET ATTENDANCE => ${employeeData.id}");
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
        debugPrint("GET ATTENDANCE ERROR => ${e.toString()}");
      }

      return attendancesList!;
    } catch (e) {
      debugPrint("GET ATTENDANCE ERROR => ${e.toString()}");
      throw ErrorEmptyResponse();
    }
  }

  Future<Attendance> getTodayAttendance() async {
    try {
      Employee employeeData = await getEmployee();
      debugPrint("GET ATTENDANCE => ${employeeData.id}");
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
      return attendance;
    } catch (e) {
      throw ErrorEmptyResponse();
    }
  }

  Future<int> postCheckInAttendance(
    String checkIn,
    double latitude,
    double longitude,
    String checkInImage,
  ) async {
    try {
      Employee employeeData = await getEmployee();
      debugPrint("GET EMPLOYEE CHECK IN => ${employeeData.toString()}");
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
      debugPrint("POST CHECK IN ATTENDANCE => $checkInAttendance");
      return checkInAttendance;
    } catch (e) {
      debugPrint("POST CHECK IN ATTENDANCE => ${e.toString()}");
      throw ErrorEmptyResponse();
    }
  }

  Future<bool> postCheckOutAttendance(
    String checkOut,
    double latitude,
    double longitude,
    String checkOutImage,
    String desc,
  ) async {
    try {
      Employee employeeData = await getEmployee();
      debugPrint("GET EMPLOYEE CHECK OUT => ${employeeData.toString()}");
      Attendance latestAttendance = await getTodayAttendance();
      debugPrint("GET ATTENDANCE CHECK OUT => ${latestAttendance.toString()}");
      final checkOutAttendance = await client!.callKw({
        'model': 'hr.attendance',
        'method': 'write',
        'args': [
          latestAttendance.id,
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
      debugPrint("POST CHECK OUT ATTENDANCE => $checkOutAttendance");
      return checkOutAttendance;
    } catch (e) {
      debugPrint("POST CHECK OUT ATTENDANCE => ${e.toString()}");
      throw ErrorEmptyResponse();
    }
  }
}
