import 'package:dpp_mobile/services/overtime_service.dart';

class OvertimeRepository {
  const OvertimeRepository({
    required this.service,
  });
  final OvertimeService service;

  Future<Map<String, dynamic>> getOvertimeList(String status) async =>
      service.getOvertimeList(status);
}