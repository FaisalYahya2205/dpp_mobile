import "package:dpp_mobile/main.dart";
import "package:dpp_mobile/models/attendance.dart";
import "package:dpp_mobile/models/employee.dart";
import "package:dpp_mobile/models/session.dart";
import "package:dpp_mobile/models/user.dart";
import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:odoo_rpc/odoo_rpc.dart";

class OdooService {
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

  Future<dynamic> getEmployeeData() async {
    debugPrint("GET EMPLOYEE DATA");
    final data = await client!.callKw({
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

    return {
      ...data[0],
      ...{"session_id": localSession!.first["id"]}
    };
  }

  Future<dynamic> getListAttendanceData() async {
    final employeeData = await getEmployeeData();
    debugPrint("GET LIST ATTENDANCE DATA");
    debugPrint(employeeData["id"].toString());
    debugPrint(getAttendanceFields().toString());
    final data = await client!.callKw({
      'model': 'hr.attendance',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ["employee_id", "=", employeeData["id"]],
        ],
        'fields': getAttendanceFields(),
      },
    });

    return {
      ...{"attendance_list": data},
      ...{"session_id": localSession!.first["id"]}
    };
  }

  Future<dynamic> getAttendanceData(String date) async {
    debugPrint("GET EMPLOYEE DATA => $date");
    final employeeData = await getEmployeeData();
    final data = await client!.callKw({
      'model': 'hr.attendance',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ["employee_id", "=", employeeData["id"]],
          ["check_out", "like", "%$date%"],
        ],
        'fields': getAttendanceFields(),
        'limit': 1,
      },
    });

    return {
      ...data[0],
      ...{"session_id": localSession!.first["id"]}
    };
  }
}
