import 'package:dpp_mobile/models/attendance.dart';
import 'package:dpp_mobile/repository/attendance_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "attendance_event.dart";
part "attendance_state.dart";

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc({
    required this.attendanceRepository,
  }) : super(AttendanceState()) {
    on<GetAttendance>(_mapGetAttendanceEventToState);
    on<CheckInAttendance>(_mapCheckInAttendanceEventToState);
    on<CheckOutAttendance>(_mapCheckOutAttendanceEventToState);
  }

  final AttendanceRepository attendanceRepository;

  void _mapGetAttendanceEventToState(
      GetAttendance event, Emitter<AttendanceState> emit) async {
    try {
      emit(state.copyWith(status: AttendanceStatus.loading));
      Map<String, dynamic> result =
          await attendanceRepository.getAttendanceList();
      List<Attendance> attendance = result["data"];

      emit(
        state.copyWith(
          status: AttendanceStatus.success,
          attendances: attendance,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: AttendanceStatus.error));
    }
  }

  void _mapCheckInAttendanceEventToState(
      CheckInAttendance event, Emitter<AttendanceState> emit) async {
    try {
      emit(state.copyWith(status: AttendanceStatus.loading));
      Map<String, dynamic> result = await attendanceRepository.checkIn(
        event.checkIn,
        event.latitude,
        event.longitude,
        event.checkInImage,
      );

      emit(
        state.copyWith(
          status: AttendanceStatus.success,
          checkInResponse: result["data"],
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: AttendanceStatus.error));
    }
  }

  void _mapCheckOutAttendanceEventToState(
      CheckOutAttendance event, Emitter<AttendanceState> emit) async {
    try {
      emit(state.copyWith(status: AttendanceStatus.loading));
      Map<String, dynamic> result = await attendanceRepository.checkOut(
        event.checkOut,
        event.latitude,
        event.longitude,
        event.checkOutImage,
        event.desc,
      );

      emit(
        state.copyWith(
          status: AttendanceStatus.success,
          checkOutResponse: result["data"],
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: AttendanceStatus.error));
    }
  }
}
