import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  const LocationService();

  static const _locationServicesDisabled = 'Location services are disabled.';
  static const _locationPermissionsDenied = 'Location permissions are denied';
  static const _locationPermissionsPermanentlyDenied = 
    'Location permissions are permanently denied, we cannot request permissions.';

  Future<Position> getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationException(_locationServicesDisabled);
    }

    debugPrint('LOCATION SERVICE IS ENABLED');

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const LocationException(_locationPermissionsDenied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(_locationPermissionsPermanentlyDenied);
    }

    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      debugPrint('Error getting current position: $e');
      throw const LocationException('Failed to get current position');
    }
  }
}

class LocationException implements Exception {
  const LocationException(this.message);
  final String message;

  @override
  String toString() => message;
}
