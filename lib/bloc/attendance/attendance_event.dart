part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

class GetAttendance extends AttendanceEvent {
  const GetAttendance();
}

class CheckInAttendance extends AttendanceEvent {
  const CheckInAttendance({
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
  const CheckOutAttendance({
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
