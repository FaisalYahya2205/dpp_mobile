// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overtime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Overtime _$OvertimeFromJson(Map<String, dynamic> json) => Overtime(
      id: json['id'] == false ? null : json['id'] as int?,
      name: json['name'] == false ? null : json['name'] as String?,
      employeeId:
          json['employee_id'] == false ? null : json['employee_id'] as List<dynamic>?,
      employeeName:
          json['employee_name'] == false ? null : json['employee_name'] as String?,
      departmentId:
          json['department_id'] == false ? null : json['department_id'] as List<dynamic>?,
      jobId: json['job_id'] == false ? null : json['job_id'] as List<dynamic>?,
      coachId: json['coach_id'] == false ? null : json['coach_id'] as List<dynamic>?,
      dateFrom: json['date_from'] == false ? null : json['date_from'] as String?,
      dateTo: json['date_to'] == false ? null : json['date_to'] as String?,
      daysNoTmp:
          json['days_no_tmp'] == false ? null : (json['days_no_tmp'] as num?)?.toDouble(),
      payslipPaid:
          json['payslip_paid'] == false ? null : json['payslip_paid'] as bool?,
      publicHoliday:
          json['public_holiday'] == false ? null : json['public_holiday'] as String?,
      state: json['state'] == false ? null : json['state'] as String?,
      desc: json['desc'] == false ? null : json['desc'] as String?,
      reviewerIds:
          json['reviewer_ids'] == false ? null : json['reviewer_ids'] as List<dynamic>?,
      overtimeTypeId:
          json['overtime_type_id'] == false ? null : json['overtime_type_id'] as Map<String, dynamic>?,
      rateHours:
          json['rate_hours'] == false ? null : (json['rate_hours'] as num?)?.toDouble(),
      nextReview:
          json['next_review'] == false ? null : json['next_review'] as String?,
    );

Map<String, dynamic> _$OvertimeToJson(Overtime instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'employee_id': instance.employeeId,
      'employee_name': instance.employeeName,
      'department_id': instance.departmentId,
      'job_id': instance.jobId,
      'coach_id': instance.coachId,
      'date_from': instance.dateFrom,
      'date_to': instance.dateTo,
      'days_no_tmp': instance.daysNoTmp,
      'payslip_paid': instance.payslipPaid,
      'public_holiday': instance.publicHoliday,
      'state': instance.state,
      'desc': instance.desc,
      'reviewer_ids': instance.reviewerIds,
      'overtime_type_id': instance.overtimeTypeId,
      'rate_hours': instance.rateHours,
      'next_review': instance.nextReview,
    };
