import 'package:dpp_mobile/models/overtime.dart';
import 'package:dpp_mobile/services/overtime_service.dart';

class OvertimeRepository {
  const OvertimeRepository({
    required this.service,
  });
  final OvertimeService service;

  Future<Map<String, dynamic>> getOvertimeList(String status) async {
    try {
      return await service.getOvertimeList(status);
    } catch (e) {
      return {
        "success": false,
        "errorMessage": "Failed to fetch overtime list",
        "data": Overtime.emptyList,
      };
    }
  }
}