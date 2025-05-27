
import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/models/timesheet.dart';
import 'package:dpp_mobile/services/employee_service.dart';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:translator/translator.dart';

class TimesheetService {
  const TimesheetService({required this.translator});

  final GoogleTranslator translator;

  static const _model = 'account.analytic.line';
  static const _searchReadMethod = 'search_read';
  static const _createMethod = 'create';
  static const _employeeAccessDenied = 'Employee Access Denied';
  static const _formatInvalid = 'Format Invalid';
  static const _binSize = {'bin_size': true};

  List<String> getTimesheetFields() => [
        'id',
        'employee_id',
        'date',
        'project_id',
        'task_id',
        'name',
        'unit_amount',
        'project_name',
        'task_name',
      ];

  Future<Map<String, dynamic>> getTimesheetList(String date) async {
    try {
      final employeeService = EmployeeService(translator: translator);
      final getEmployee = await employeeService.getEmployee();
      final employeeData = getEmployee['data'] as Employee;

      if (employeeData.id == 0) {
        return _createErrorResponse(_employeeAccessDenied, Timesheet.emptyList);
      }

      debugPrint('GET TIMESHEET DATE => $date');

      final data = await client!.callKw({
        'model': _model,
        'method': _searchReadMethod,
        'args': [],
        'kwargs': {
          'context': _binSize,
          'domain': [
            ['employee_id', '=', employeeData.id],
            ['date', '=', date],
          ],
          'fields': getTimesheetFields(),
        },
      });

      try {
        final timesheetList = List<Timesheet>.from(
          data.map((item) => Timesheet.fromJson(item)),
        );

        return {
          'success': true,
          'errorMessage': '',
          'data': timesheetList,
        };
      } catch (e) {
        debugPrint('Error processing timesheet data: $e');
        return _createErrorResponse(_formatInvalid, Timesheet.emptyList);
      }
    } on OdooException catch (e) {
      debugPrint('Odoo error: $e');
      final message = e.message.split('message: ')[2].split(',')[0];
      final errorMessage = await translator.translate(
        message,
        from: 'en',
        to: 'id',
      );
      return _createErrorResponse(errorMessage.text, Timesheet.emptyList);
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return _createErrorResponse(
        'An unexpected error occurred',
        Timesheet.emptyList,
      );
    }
  }

  Future<Map<String, dynamic>> postTimesheetRequest(
    String date,
    String projectId,
    String taskId,
    String name,
    double unitAmount,
  ) async {
    try {
      final employeeService = EmployeeService(translator: translator);
      final getEmployee = await employeeService.getEmployee();
      final employeeData = getEmployee['data'] as Employee;

      if (employeeData.id == 0) {
        return _createErrorResponse(_employeeAccessDenied, 0);
      }

      final requestResponse = await client!.callKw({
        'model': _model,
        'method': _createMethod,
        'args': [
          {
            'employee_id': employeeData.id,
            'date': date,
            'project_id': int.parse(projectId),
            'task_id': int.parse(taskId),
            'name': name,
            'unit_amount': unitAmount,
          },
        ],
        'kwargs': {},
      });

      return {
        'success': true,
        'errorMessage': '',
        'data': requestResponse,
      };
    } on OdooException catch (e) {
      debugPrint('Odoo error: $e');
      final message = e.message.split('message: ')[2].split(',')[0];
      final errorMessage = await translator.translate(
        message,
        from: 'en',
        to: 'id',
      );
      return _createErrorResponse(errorMessage.text, 0);
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return _createErrorResponse(
        'An unexpected error occurred',
        0,
      );
    }
  }

  Map<String, dynamic> _createErrorResponse(String message, dynamic data) {
    return {
      'success': false,
      'errorMessage': message,
      'data': data,
    };
  }
}