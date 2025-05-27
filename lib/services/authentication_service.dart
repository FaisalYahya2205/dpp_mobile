import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/host_address.dart';
import 'package:dpp_mobile/models/result_error.dart';
import 'package:dpp_mobile/models/session.dart';
import 'package:dpp_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:translator/translator.dart';
import 'dart:convert';

class AuthenticationService {
  const AuthenticationService({
    required this.translator,
  });

  final GoogleTranslator translator;

  static const _model = 'res.users';
  static const _method = 'search_read';
  static const _sessionTable = 'session';
  static const _hostAddressTable = 'host_address';
  static const _authenticationError = 'Authentication Error';
  static const _serverError = 'Terjadi masalah dengan server...';

  Future<Map<String, dynamic>> authentication(
    String username,
    String password,
    String hostUrl,
    String databaseName,
  ) async {
    debugPrint('AUTH => $username $password $hostUrl $databaseName');
    debugPrint('AUTH => init Client $hostUrl');
    
    client = OdooClient(hostUrl);
    debugPrint('AUTH => ${client.toString()}');

    try {
      debugPrint('AUTH => init Session');
      final odooSession = await client!.authenticate(
        databaseName,
        username,
        password,
      );
      debugPrint('AUTH => $odooSession');

      if (odooSession.runtimeType != OdooSession) {
        debugPrint('Session INVALID');
        return _createErrorResponse(_authenticationError);
      }

      debugPrint('AUTH => init User');
      final userData = await client!.callKw({
        'model': _model,
        'method': _method,
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [
            ['email', '=', username]
          ],
          'fields': ['id', 'partner_id'],
        },
      });

      final session = Session(
        userId: odooSession.userId,
        partnerId: userData[0]['partner_id'][0],
        sessionId: odooSession.id,
        userLogin: odooSession.userLogin,
        userName: odooSession.userName,
        password: password,
        loginState: 1,
      );

      final hostAddress = HostAddress(
        userId: odooSession.userId,
        hostUrl: hostUrl,
        databaseName: databaseName,
      );

      await databaseHelper!.insertQuery(
        _sessionTable,
        json.decode(session.toJson()),
      );

      await databaseHelper!.insertQuery(
        _hostAddressTable,
        json.decode(hostAddress.toJson()),
      );

      debugPrint('AUTH => All Set');

      return {
        'success': true,
        'errorMessage': '',
        'data': {},
      };
    } on OdooException catch (e) {
      debugPrint('OdooException: $e');
      final message = e.message.split('message: ')[2].split(',')[0];
      final errorMessage = await translator.translate(
        message,
        from: 'en',
        to: 'id',
      );
      return _createErrorResponse(errorMessage.text);
    } on ClientException {
      return _createErrorResponse(_serverError);
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw ErrorEmptyResponse();
    }
  }

  Map<String, dynamic> _createErrorResponse(String errorMessage) {
    return {
      'success': false,
      'errorMessage': errorMessage,
      'data': {},
    };
  }
}
