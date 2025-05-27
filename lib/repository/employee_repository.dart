import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/services/employee_service.dart';

class EmployeeRepository {
  const EmployeeRepository({
    required this.service,
  });
  final EmployeeService service;

  Future<Map<String, dynamic>> getEmployee() async {
    try {
      return await service.getEmployee();
    } catch (e) {
      return {
        "success": false,
        "errorMessage": "Failed to fetch employee data",
        "data": Employee.empty,
      };
    }
  }
}
