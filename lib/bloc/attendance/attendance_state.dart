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
  const AttendanceState({
    this.status = AttendanceStatus.initial,
    this.attendances = Attendance.emptyList,
    this.checkInResponse = 0,
    this.checkOutResponse = false,
    this.errorMessage = '',
  });

  final List<Attendance> attendances;
  final int checkInResponse;
  final bool checkOutResponse;
  final AttendanceStatus status;
  final String errorMessage;

  @override
  List<Object?> get props => [
        status,
        attendances,
        checkInResponse,
        checkOutResponse,
        errorMessage,
      ];

  AttendanceState copyWith({
    List<Attendance>? attendances,
    int? checkInResponse,
    bool? checkOutResponse,
    AttendanceStatus? status,
    String? errorMessage,
  }) {
    return AttendanceState(
      attendances: attendances ?? this.attendances,
      checkInResponse: checkInResponse ?? this.checkInResponse,
      checkOutResponse: checkOutResponse ?? this.checkOutResponse,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
