import 'package:dpp_mobile/services/employee_service.dart';

class EmployeeRepository {
  const EmployeeRepository({
    required this.service,
  });
  final EmployeeService service;

  Future<Map<String, dynamic>> getEmployee() async => service.getEmployee();
}
