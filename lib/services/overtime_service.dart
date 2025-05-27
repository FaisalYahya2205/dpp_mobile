import 'dart:convert';

import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/models/overtime.dart';
import 'package:dpp_mobile/services/employee_service.dart';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:translator/translator.dart';

class OvertimeService {
  const OvertimeService({required this.translator});

  final GoogleTranslator translator;

  static const _model = 'hr.overtime';
  static const _overtimeTypeModel = 'overtime.type';
  static const _searchReadMethod = 'search_read';
  static const _createMethod = 'create';
  static const _employeeAccessDenied = 'Employee Access Denied';
  static const _formatInvalid = 'Format Invalid';
  static const _binSize = {'bin_size': true};

  Future<Map<String, dynamic>> getOvertimeList(String status) async {
    try {
      final employeeService = EmployeeService(translator: translator);
      final getEmployee = await employeeService.getEmployee();
      final employeeData = getEmployee['data'] as Employee;

      if (employeeData.id == 0) {
        return _createErrorResponse(_employeeAccessDenied, Overtime.emptyList);
      }

      debugPrint('GET OVERTIME STATUS => $status');

      final data = await client!.callKw({
        'model': _model,
        'method': _searchReadMethod,
        'args': [],
        'kwargs': {
          'context': _binSize,
          'domain': [
            ['employee_id', '=', employeeData.id],
            ['state', '=', status],
          ],
          'fields': getOvertimeFields(),
        },
      });

      try {
        for (final overtime in data) {
          if (overtime['overtime_type_id'] != false) {
            final overtimeType = await client!.callKw({
              'model': _overtimeTypeModel,
              'method': _searchReadMethod,
              'args': [],
              'kwargs': {
                'context': _binSize,
                'domain': [
                  ['id', '=', overtime['overtime_type_id'][0]],
                ],
                'fields': ['id', 'name'],
              },
            });

            overtime['overtime_type_id'] = overtimeType[0];
          }
        }

        final overtimesList = List<Overtime>.from(
          data.map((item) => Overtime.fromJson(json.encode(item))),
        );

        return {
          'success': true,
          'errorMessage': '',
          'data': overtimesList,
        };
      } catch (e) {
        debugPrint('Error processing overtime data: $e');
        return _createErrorResponse(_formatInvalid, Overtime.emptyList);
      }
    } on OdooException catch (e) {
      debugPrint('Odoo error: $e');
      final message = e.message.split('message: ')[2].split(',')[0];
      final errorMessage = await translator.translate(
        message,
        from: 'en',
        to: 'id',
      );
      return _createErrorResponse(errorMessage.text, Overtime.emptyList);
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return _createErrorResponse(
        'An unexpected error occurred',
        Overtime.emptyList,
      );
    }
  }

  Future<Map<String, dynamic>> postOvertimeRequest(
    String dateFrom,
    String dateTo,
    String attchdCopy,
    String desc,
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
            'date_from': dateFrom,
            'date_to': dateTo,
            'attchd_copy': attchdCopy,
            'desc': desc,
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
