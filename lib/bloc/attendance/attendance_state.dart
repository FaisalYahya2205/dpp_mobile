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
  }) : attendances = attendances ?? Attendance.emptyList;

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

class CheckInState extends Equatable {
  const CheckInState({
    this.status = AttendanceStatus.initial,
    int? checkInResponse,
  }) : checkInResponse = checkInResponse ?? 0;

  final int checkInResponse;
  final AttendanceStatus status;

  @override
  List<Object?> get props => [status, checkInResponse];

  CheckInState copyWith({
    int? checkInResponse,
    AttendanceStatus? status,
  }) {
    return CheckInState(
      checkInResponse: checkInResponse,
      status: status ?? this.status,
    );
  }
}

class CheckOutState extends Equatable {
  const CheckOutState({
    this.status = AttendanceStatus.initial,
    bool? checkOutResponse,
  }) : checkOutResponse = checkOutResponse ?? false;

  final bool checkOutResponse;
  final AttendanceStatus status;

  @override
  List<Object?> get props => [status, checkOutResponse];

  CheckOutState copyWith({
    bool? checkOutResponse,
    AttendanceStatus? status,
  }) {
    return CheckOutState(
      checkOutResponse: checkOutResponse,
      status: status ?? this.status,
    );
  }
}
