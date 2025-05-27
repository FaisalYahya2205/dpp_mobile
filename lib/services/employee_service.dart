import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:translator/translator.dart';
import 'dart:convert';

class EmployeeService {
  const EmployeeService({
    required this.translator,
  });

  final GoogleTranslator translator;

  static const _model = 'hr.employee';
  static const _method = 'search_read';
  static const _clientNotInitialized = 'Client not initialized';
  static const _notFound = 'Not Found';
  static const _invalidFormat = 'Invalid employee format';
  static const _unexpectedError = 'An unexpected error occurred';

  Future<Map<String, dynamic>> getEmployee() async {
    if (client == null) {
      return _createErrorResponse(_clientNotInitialized);
    }

    try {
      final data = await client!.callKw({
        'model': _model,
        'method': _method,
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [
            ['user_id', '=', localSession!.first['user_id']]
          ],
          'fields': getEmployeeFields(),
        },
      });

      debugPrint('GET EMPLOYEE => $data');

      if (data.isEmpty) {
        return _createErrorResponse(_notFound);
      }

      try {
        final employeeData = Employee.fromJson(json.encode(data[0]));
        return {
          'success': true,
          'errorMessage': '',
          'data': employeeData,
        };
      } catch (e) {
        debugPrint('Error parsing employee data: $e');
        return _createErrorResponse(_invalidFormat);
      }
    } on OdooException catch (e) {
      debugPrint('OdooException in getEmployee: $e');
      final message = e.message.split('message: ')[2].split(',')[0];
      final errorMessage = await translator.translate(
        message,
        from: 'en',
        to: 'id',
      );
      return _createErrorResponse(errorMessage.text);
    } catch (e) {
      debugPrint('Unexpected error in getEmployee: $e');
      return _createErrorResponse(_unexpectedError);
    }
  }

  Map<String, dynamic> _createErrorResponse(String errorMessage) {
    return {
      'success': false,
      'errorMessage': errorMessage,
      'data': Employee.empty,
    };
  }
}
