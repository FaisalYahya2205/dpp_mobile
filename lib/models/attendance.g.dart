// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      id: (json['id'] as num?)?.toInt(),
      employeeId:
          json['employee_id'] != false ? json['employee_id'][0] as int : null,
      scheduleIn:
          json['schedule_in'] != false ? json['schedule_in'] as String : null,
      checkIn: json['check_in'] != false ? json['check_in'] as String : null,
      geoCheckIn:
          json['geo_check_in'] != false ? json['geo_check_in'] as String : null,
      geoAccessCheckIn: json['geo_access_check_in'] != false ? true : false,
      geospatialAccessCheckIn:
          json['geospatial_access_check_in'] != false ? true : false,
      mapUrlCheckIn: json['map_url_check_in'] != false
          ? json['map_url_check_in'] as String
          : null,
      ismobileCheckIn: json['ismobile_check_in'] != false
          ? json['ismobile_check_in'] as bool
          : null,
      checkInImage: json['check_in_image'] != false
          ? json['check_in_image'] as String
          : null,
      scheduleOut:
          json['schedule_out'] != false ? json['schedule_out'] as String : null,
      checkOut: json['check_out'] != false ? json['check_out'] as String : null,
      geoCheckOut: json['geo_check_out'] != false
          ? json['geo_check_out'] as String
          : null,
      geoAccessCheckOut: json['geo_access_check_out'] != false
          ? true
          : false,
      geospatialAccessCheckOut: json['geospatial_access_check_out'] != false
          ? true
          : false,
      mapUrlCheckOut: json['map_url_check_out'] != false
          ? json['map_url_check_out'] as String
          : null,
      ismobileCheckOut: json['ismobile_check_out'] != false
          ? json['ismobile_check_out'] as bool
          : null,
      checkOutImage: json['check_out_image'] != false
          ? json['check_out_image'] as String
          : null,
      desc: json['desc'] != false ? json['desc'] as String : null,
      workedHours:
          json['worked_hours'] != false ? json['worked_hours'] as double : null,
      signInSurveyId: json['sign_in_survey_id'] != false
          ? (json['sign_in_survey_id'] as List<dynamic>?)?.last as String
          : null,
      signOutSurveyId: json['sign_out_survey_id'] != false
          ? (json['sign_out_survey_id'] as List<dynamic>?)?.last as String
          : null,
      signInSurveyLineIds: json['sign_in_survey_line_ids'] != false
          ? (json['sign_in_survey_line_ids'] as List<dynamic>?)
          : [],
      signOutSurveyLineIds: json['sign_out_survey_line_ids'] != false
          ? (json['sign_out_survey_line_ids'] as List<dynamic>?)
          : [],
    );

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_id': instance.employeeId,
      'schedule_in': instance.scheduleIn,
      'check_in': instance.checkIn,
      'geo_check_in': instance.geoCheckIn,
      'geo_access_check_in': instance.geoAccessCheckIn,
      'geospatial_access_check_in': instance.geospatialAccessCheckIn,
      'map_url_check_in': instance.mapUrlCheckIn,
      'ismobile_check_in': instance.ismobileCheckIn,
      'check_in_image': instance.checkInImage,
      'schedule_out': instance.scheduleOut,
      'check_out': instance.checkOut,
      'geo_check_out': instance.geoCheckOut,
      'geo_access_check_out': instance.geoAccessCheckOut,
      'geospatial_access_check_out': instance.geospatialAccessCheckOut,
      'map_url_check_out': instance.mapUrlCheckOut,
      'ismobile_check_out': instance.ismobileCheckOut,
      'check_out_image': instance.checkOutImage,
      'desc': instance.desc,
      'worked_hours': instance.workedHours,
      'sign_in_survey_id': instance.signInSurveyId,
      'sign_out_survey_id': instance.signOutSurveyId,
      'sign_in_survey_line_ids': instance.signInSurveyLineIds,
      'sign_out_survey_line_ids': instance.signOutSurveyLineIds,
    };
