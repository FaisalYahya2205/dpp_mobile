part of 'attendance_bloc.dart';

class AttendanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAttendance extends AttendanceEvent {
  @override
  List<Object?> get props => [];
}

class CheckInAttendance extends AttendanceEvent {
  CheckInAttendance({
    required this.checkIn,
    required this.latitude,
    required this.longitude,
    required this.checkInImage,
  });

  final String checkIn;
  final double latitude;
  final double longitude;
  final String checkInImage;

  @override
  List<Object?> get props => [checkIn, latitude, longitude, checkInImage];
}

class CheckOutAttendance extends AttendanceEvent {
  CheckOutAttendance({
    required this.checkOut,
    required this.latitude,
    required this.longitude,
    required this.checkOutImage,
    required this.desc,
  });

  final String checkOut;
  final double latitude;
  final double longitude;
  final String checkOutImage;
  final String desc;

  @override
  List<Object?> get props => [
        checkOut,
        latitude,
        longitude,
        checkOutImage,
        desc,
      ];
}
