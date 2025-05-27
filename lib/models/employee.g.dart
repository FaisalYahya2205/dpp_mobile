// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: json['id'] == false ? null : json['id'] as int?,
      name: json['name'] == false ? null : json['name'] as String?,
      nrp: json['nrp'] == false ? null : json['nrp'] as String?,
      jobId: json['job_id'] == false ? null : json['job_id'][0] as int?,
      jobTitle:
          json['job_title'] == false ? null : json['job_title'] as String?,
      workEmail:
          json['work_email'] == false ? null : json['work_email'] as String?,
      workPhone:
          json['work_phone'] == false ? null : json['work_phone'] as String?,
      addressId:
          json['address_id'] == false ? null : json['address_id'][1] as String?,
      parentId:
          json['parent_id'] == false ? null : json['parent_id'][1] as String?,
      lastUpdate:
          json['last_update'] == false ? null : json['last_update'] as String?,
      image128: json['image128'] == false ? null : json['image128'] as String?,
      image1920:
          json['image1920'] == false ? null : json['image1920'] as String?,
      tz: json['tz'] == false ? null : json['tz'] as String?,
      lastCheckIn: json['last_check_in'] == false
          ? null
          : json['last_check_in'] as String?,
      lastCheckOut: json['last_check_out'] == false
          ? null
          : json['last_check_out'] as String?,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nrp': instance.nrp,
      'job_id': instance.jobId,
      'job_title': instance.jobTitle,
      'work_email': instance.workEmail,
      'work_phone': instance.workPhone,
      'address_id': instance.addressId,
      'parent_id': instance.parentId,
      'last_update': instance.lastUpdate,
      'image128': instance.image128,
      'image1920': instance.image1920,
      'tz': instance.tz,
      'last_check_in': instance.lastCheckIn,
      'last_check_out': instance.lastCheckOut,
    };
