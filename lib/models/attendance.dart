// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'attendance.g.dart';

/// List of field names used in the Attendance model
List<String> getAttendanceFields() => [
      'id',
      'employee_id',
      'schedule_in',
      'check_in',
      'geo_check_in',
      'geo_access_check_in',
      'geospatial_access_check_in',
      'map_url_check_in',
      'ismobile_check_in',
      'check_in_image',
      'schedule_out',
      'check_out',
      'geo_check_out',
      'geo_access_check_out',
      'geospatial_access_check_out',
      'map_url_check_out',
      'ismobile_check_out',
      'check_out_image',
      'desc',
      'worked_hours',
      'sign_in_survey_id',
      'sign_out_survey_id',
      'sign_in_survey_line_ids',
      'sign_out_survey_line_ids',
    ];

/// Model class representing attendance records
@JsonSerializable(fieldRename: FieldRename.snake)
class Attendance {
  final int? id;
  final int? employeeId;
  final String? scheduleIn;
  final String? checkIn;
  final String? geoCheckIn;
  final bool? geoAccessCheckIn;
  final bool? geospatialAccessCheckIn;
  final String? mapUrlCheckIn;
  final bool? ismobileCheckIn;
  final String? checkInImage;
  final String? scheduleOut;
  final String? checkOut;
  final String? geoCheckOut;
  final bool? geoAccessCheckOut;
  final bool? geospatialAccessCheckOut;
  final String? mapUrlCheckOut;
  final bool? ismobileCheckOut;
  final String? checkOutImage;
  final String? desc;
  final double? workedHours;
  final String? signInSurveyId;
  final String? signOutSurveyId;
  final List<dynamic>? signInSurveyLineIds;
  final List<dynamic>? signOutSurveyLineIds;

  const Attendance({
    this.id,
    this.employeeId,
    this.scheduleIn,
    this.checkIn,
    this.geoCheckIn,
    this.geoAccessCheckIn,
    this.geospatialAccessCheckIn,
    this.mapUrlCheckIn,
    this.ismobileCheckIn,
    this.checkInImage,
    this.scheduleOut,
    this.checkOut,
    this.geoCheckOut,
    this.geoAccessCheckOut,
    this.geospatialAccessCheckOut,
    this.mapUrlCheckOut,
    this.ismobileCheckOut,
    this.checkOutImage,
    this.desc,
    this.workedHours,
    this.signInSurveyId,
    this.signOutSurveyId,
    this.signInSurveyLineIds,
    this.signOutSurveyLineIds,
  });

  static const empty = Attendance(
    id: 0,
    employeeId: 0,
    scheduleIn: "",
    checkIn: "",
    geoCheckIn: "",
    geoAccessCheckIn: false,
    geospatialAccessCheckIn: false,
    mapUrlCheckIn: "",
    ismobileCheckIn: false,
    checkInImage: "",
    scheduleOut: "",
    checkOut: "",
    geoCheckOut: "",
    geoAccessCheckOut: false,
    geospatialAccessCheckOut: false,
    mapUrlCheckOut: "",
    ismobileCheckOut: false,
    checkOutImage: "",
    desc: "",
    workedHours: 0,
    signInSurveyId: "",
    signOutSurveyId: "",
    signInSurveyLineIds: [],
    signOutSurveyLineIds: [],
  );

  static const List<Attendance> emptyList = [];

  Attendance copyWith({
    int? id,
    int? employeeId,
    String? scheduleIn,
    String? checkIn,
    String? geoCheckIn,
    bool? geoAccessCheckIn,
    bool? geospatialAccessCheckIn,
    String? mapUrlCheckIn,
    bool? ismobileCheckIn,
    String? checkInImage,
    String? scheduleOut,
    String? checkOut,
    String? geoCheckOut,
    bool? geoAccessCheckOut,
    bool? geospatialAccessCheckOut,
    String? mapUrlCheckOut,
    bool? ismobileCheckOut,
    String? checkOutImage,
    String? desc,
    double? workedHours,
    String? signInSurveyId,
    String? signOutSurveyId,
    List<dynamic>? signInSurveyLineIds,
    List<dynamic>? signOutSurveyLineIds,
  }) {
    return Attendance(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      scheduleIn: scheduleIn ?? this.scheduleIn,
      checkIn: checkIn ?? this.checkIn,
      geoCheckIn: geoCheckIn ?? this.geoCheckIn,
      geoAccessCheckIn: geoAccessCheckIn ?? this.geoAccessCheckIn,
      geospatialAccessCheckIn: geospatialAccessCheckIn ?? this.geospatialAccessCheckIn,
      mapUrlCheckIn: mapUrlCheckIn ?? this.mapUrlCheckIn,
      ismobileCheckIn: ismobileCheckIn ?? this.ismobileCheckIn,
      checkInImage: checkInImage ?? this.checkInImage,
      scheduleOut: scheduleOut ?? this.scheduleOut,
      checkOut: checkOut ?? this.checkOut,
      geoCheckOut: geoCheckOut ?? this.geoCheckOut,
      geoAccessCheckOut: geoAccessCheckOut ?? this.geoAccessCheckOut,
      geospatialAccessCheckOut: geospatialAccessCheckOut ?? this.geospatialAccessCheckOut,
      mapUrlCheckOut: mapUrlCheckOut ?? this.mapUrlCheckOut,
      ismobileCheckOut: ismobileCheckOut ?? this.ismobileCheckOut,
      checkOutImage: checkOutImage ?? this.checkOutImage,
      desc: desc ?? this.desc,
      workedHours: workedHours ?? this.workedHours,
      signInSurveyId: signInSurveyId ?? this.signInSurveyId,
      signOutSurveyId: signOutSurveyId ?? this.signOutSurveyId,
      signInSurveyLineIds: signInSurveyLineIds ?? this.signInSurveyLineIds,
      signOutSurveyLineIds: signOutSurveyLineIds ?? this.signOutSurveyLineIds,
    );
  }

  factory Attendance.fromJson(String source) => 
      _$AttendanceFromJson(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(_$AttendanceToJson(this));

  @override
  String toString() {
    return 'Attendance(id: $id, employeeId: $employeeId, scheduleIn: $scheduleIn, checkIn: $checkIn, geoCheckIn: $geoCheckIn, geoAccessCheckIn: $geoAccessCheckIn, geospatialAccessCheckIn: $geospatialAccessCheckIn, mapUrlCheckIn: $mapUrlCheckIn, ismobileCheckIn: $ismobileCheckIn, checkInImage: $checkInImage, scheduleOut: $scheduleOut, checkOut: $checkOut, geoCheckOut: $geoCheckOut, geoAccessCheckOut: $geoAccessCheckOut, geospatialAccessCheckOut: $geospatialAccessCheckOut, mapUrlCheckOut: $mapUrlCheckOut, ismobileCheckOut: $ismobileCheckOut, checkOutImage: $checkOutImage, desc: $desc, workedHours: $workedHours, signInSurveyId: $signInSurveyId, signOutSurveyId: $signOutSurveyId, signInSurveyLineIds: $signInSurveyLineIds, signOutSurveyLineIds: $signOutSurveyLineIds)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Attendance &&
        other.id == id &&
        other.employeeId == employeeId &&
        other.scheduleIn == scheduleIn &&
        other.checkIn == checkIn &&
        other.geoCheckIn == geoCheckIn &&
        other.geoAccessCheckIn == geoAccessCheckIn &&
        other.geospatialAccessCheckIn == geospatialAccessCheckIn &&
        other.mapUrlCheckIn == mapUrlCheckIn &&
        other.ismobileCheckIn == ismobileCheckIn &&
        other.checkInImage == checkInImage &&
        other.scheduleOut == scheduleOut &&
        other.checkOut == checkOut &&
        other.geoCheckOut == geoCheckOut &&
        other.geoAccessCheckOut == geoAccessCheckOut &&
        other.geospatialAccessCheckOut == geospatialAccessCheckOut &&
        other.mapUrlCheckOut == mapUrlCheckOut &&
        other.ismobileCheckOut == ismobileCheckOut &&
        other.checkOutImage == checkOutImage &&
        other.desc == desc &&
        other.workedHours == workedHours &&
        other.signInSurveyId == signInSurveyId &&
        other.signOutSurveyId == signOutSurveyId &&
        listEquals(other.signInSurveyLineIds, signInSurveyLineIds) &&
        listEquals(other.signOutSurveyLineIds, signOutSurveyLineIds);
  }

  @override
  int get hashCode {
    return Object.hashAll([
      id,
      employeeId,
      scheduleIn,
      checkIn,
      geoCheckIn,
      geoAccessCheckIn,
      geospatialAccessCheckIn,
      mapUrlCheckIn,
      ismobileCheckIn,
      checkInImage,
      scheduleOut,
      checkOut,
      geoCheckOut,
      geoAccessCheckOut,
      geospatialAccessCheckOut,
      mapUrlCheckOut,
      ismobileCheckOut,
      checkOutImage,
      desc,
      workedHours,
      signInSurveyId,
      signOutSurveyId,
      Object.hashAll(signInSurveyLineIds ?? []),
      Object.hashAll(signOutSurveyLineIds ?? []),
    ]);
  }
}
