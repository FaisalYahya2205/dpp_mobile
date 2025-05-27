import 'package:dpp_mobile/models/attendance.dart';
import 'package:dpp_mobile/repository/attendance_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "attendance_event.dart";
part "attendance_state.dart";

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc({
    required this.attendanceRepository,
  }) : super(const AttendanceState()) {
    on<GetAttendance>(_mapGetAttendanceEventToState);
    on<CheckInAttendance>(_mapCheckInAttendanceEventToState);
    on<CheckOutAttendance>(_mapCheckOutAttendanceEventToState);
  }

  final AttendanceRepository attendanceRepository;

  Future<void> _mapGetAttendanceEventToState(
    GetAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AttendanceStatus.loading));
      
      final result = await attendanceRepository.getAttendanceList();
      
      if (result["success"] == true) {
        final attendances = result["data"] as List<Attendance>;
        emit(state.copyWith(
          status: AttendanceStatus.success,
          attendances: attendances,
          errorMessage: '',
        ));
      } else {
        emit(state.copyWith(
          status: AttendanceStatus.error,
          errorMessage: result["errorMessage"] as String,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: AttendanceStatus.error,
        errorMessage: 'Failed to fetch attendance list',
      ));
    }
  }

  Future<void> _mapCheckInAttendanceEventToState(
    CheckInAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AttendanceStatus.loading));
      
      final result = await attendanceRepository.checkIn(
        event.checkIn,
        event.latitude,
        event.longitude,
        event.checkInImage,
      );
      
      if (result["success"] == true) {
        final checkInResponse = result["data"] as int;
        emit(state.copyWith(
          status: AttendanceStatus.success,
          checkInResponse: checkInResponse,
          errorMessage: '',
        ));
      } else {
        emit(state.copyWith(
          status: AttendanceStatus.error,
          errorMessage: result["errorMessage"] as String,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: AttendanceStatus.error,
        errorMessage: 'Failed to check in',
      ));
    }
  }

  Future<void> _mapCheckOutAttendanceEventToState(
    CheckOutAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AttendanceStatus.loading));
      
      final result = await attendanceRepository.checkOut(
        event.checkOut,
        event.latitude,
        event.longitude,
        event.checkOutImage,
        event.desc,
      );
      
      if (result["success"] == true) {
        final checkOutResponse = result["data"] as bool;
        emit(state.copyWith(
          status: AttendanceStatus.success,
          checkOutResponse: checkOutResponse,
          errorMessage: '',
        ));
      } else {
        emit(state.copyWith(
          status: AttendanceStatus.error,
          errorMessage: result["errorMessage"] as String,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: AttendanceStatus.error,
        errorMessage: 'Failed to check out',
      ));
    }
  }
}
