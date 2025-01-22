import 'package:dpp_mobile/models/attendance.dart';
import 'package:dpp_mobile/repository/odoo_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AttendanceStatus { initial, success, error, loading }

extension AttendanceStatusX on AttendanceStatus {
  bool get isInitial => this == AttendanceStatus.initial;
  bool get isSuccess => this == AttendanceStatus.success;
  bool get isError => this == AttendanceStatus.error;
  bool get isLoading => this == AttendanceStatus.loading;
}

class AttendanceState extends Equatable {
  AttendanceState({
    this.status = AttendanceStatus.initial,
    List<Attendance>? attendances,
  })  : attendances = attendances ?? Attendance.emptyList;

  final List<Attendance> attendances;
  final AttendanceStatus status;

  @override
  List<Object?> get props => [status, attendances];

  AttendanceState copyWith({
    List<Attendance>? attendances,
    AttendanceStatus? status,
  }) {
    return AttendanceState(
      attendances: attendances,
      status: status ?? this.status,
    );
  }
}

class AttendanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAttendance extends AttendanceEvent {
  @override
  List<Object?> get props => [];
}

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc({
    required this.odooRepository,
  }) : super(AttendanceState()) {
    on<GetAttendance>(_mapGetAttendanceEventToState);
  }

  final OdooRepository odooRepository;

  void _mapGetAttendanceEventToState(
      GetAttendance event, Emitter<AttendanceState> emit) async {
    try {
      emit(state.copyWith(status: AttendanceStatus.loading));
      final attendance = await odooRepository.getAttendanceList();
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
}
