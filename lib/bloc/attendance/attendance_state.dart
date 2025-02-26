part of 'attendance_bloc.dart';

enum AttendanceStatus {
  initial,
  success,
  error,
  loading,
}

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
    int? checkInResponse,
    bool? checkOutResponse,
  })  : attendances = attendances ?? Attendance.emptyList,
        checkInResponse = checkInResponse ?? 0,
        checkOutResponse = checkOutResponse ?? false;

  final List<Attendance> attendances;
  final int checkInResponse;
  final bool checkOutResponse;
  final AttendanceStatus status;

  @override
  List<Object?> get props => [
        status,
        attendances,
        checkInResponse,
        checkOutResponse,
      ];

  AttendanceState copyWith({
    List<Attendance>? attendances,
    int? checkInResponse,
    bool? checkOutResponse,
    AttendanceStatus? status,
  }) {
    return AttendanceState(
      attendances: attendances,
      checkInResponse: checkInResponse,
      checkOutResponse: checkOutResponse,
      status: status ?? this.status,
    );
  }
}
