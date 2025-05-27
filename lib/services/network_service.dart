import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkService {
  const NetworkService();

  static const _noInternetConnection = 'No internet connection';
  static const _serverUnreachable = 'Server is unreachable';
  static const _timeoutError = 'Connection timeout';
  static const _defaultTimeout = Duration(seconds: 30);

  Future<bool> isConnected() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      debugPrint('Error checking connectivity: $e');
      return false;
    }
  }

  Future<bool> canReachServer(String url) async {
    try {
      final result = await InternetAddress.lookup(url);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (e) {
      debugPrint('Socket error checking server reachability: $e');
      return false;
    } catch (e) {
      debugPrint('Error checking server reachability: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> checkConnection() async {
    try {
      final isNetworkConnected = await isConnected();
      if (!isNetworkConnected) {
        return _createErrorResponse(_noInternetConnection);
      }

      final canReach = await canReachServer('google.com');
      if (!canReach) {
        return _createErrorResponse(_serverUnreachable);
      }

      return {
        'success': true,
        'errorMessage': '',
        'data': true,
      };
    } catch (e) {
      debugPrint('Unexpected error checking connection: $e');
      return _createErrorResponse(_timeoutError);
    }
  }

  Future<Map<String, dynamic>> checkConnectionWithTimeout({
    Duration timeout = _defaultTimeout,
  }) async {
    try {
      final result = await Future.any([
        checkConnection(),
        Future.delayed(timeout, () => _createErrorResponse(_timeoutError)),
      ]);

      return result;
    } catch (e) {
      debugPrint('Error in connection check with timeout: $e');
      return _createErrorResponse(_timeoutError);
    }
  }

  Map<String, dynamic> _createErrorResponse(String message) {
    return {
      'success': false,
      'errorMessage': message,
      'data': false,
    };
  }
}
