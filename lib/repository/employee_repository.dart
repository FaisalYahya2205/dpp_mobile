import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/services/employee_service.dart';

class EmployeeRepository {
  const EmployeeRepository({
    required this.service,
  });
  final EmployeeService service;

  Future<Employee> getEmployee() async => service.getEmployee();
}
