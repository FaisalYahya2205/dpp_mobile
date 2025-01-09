import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/models/result_error.dart';

class EmployeeService {
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
      Employee employeeData = Employee.fromMap(data[0]);
      return employeeData;
    } catch (e) {
      throw ErrorEmptyResponse();
    }
  }
}
