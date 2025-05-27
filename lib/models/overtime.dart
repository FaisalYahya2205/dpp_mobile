// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'overtime.g.dart';

// ignore_for_file: non_constant_identifier_names

/// List of field names used in the Overtime model
List<String> getOvertimeFields() => [
      'id',
      'name',
      'employee_id',
      'employee_name',
      'department_id',
      'job_id',
      'coach_id',
      'date_from',
      'date_to',
      'days_no_tmp',
      'payslip_paid',
      'public_holiday',
      'state',
      'desc',
      'reviewer_ids',
      'overtime_type_id',
      'rate_hours',
      'next_review',
    ];

/// Model class representing overtime records
@JsonSerializable(fieldRename: FieldRename.snake)
class Overtime {
  final int? id;
  final String? name;
  final List<dynamic>? employeeId;
  final String? employeeName;
  final List<dynamic>? departmentId;
  final List<dynamic>? jobId;
  final List<dynamic>? coachId;
  final String? dateFrom;
  final String? dateTo;
  final double? daysNoTmp;
  final bool? payslipPaid;
  final String? publicHoliday;
  final String? state;
  final String? desc;
  final List<dynamic>? reviewerIds;
  final Map<String, dynamic>? overtimeTypeId;
  final double? rateHours;
  final String? nextReview;

  const Overtime({
    this.id,
    this.name,
    this.employeeId,
    this.employeeName,
    this.departmentId,
    this.jobId,
    this.coachId,
    this.dateFrom,
    this.dateTo,
    this.daysNoTmp,
    this.payslipPaid,
    this.publicHoliday,
    this.state,
    this.desc,
    this.reviewerIds,
    this.overtimeTypeId,
    this.rateHours,
    this.nextReview,
  });

  Overtime copyWith({
    int? id,
    String? name,
    List<dynamic>? employeeId,
    String? employeeName,
    List<dynamic>? departmentId,
    List<dynamic>? jobId,
    List<dynamic>? coachId,
    String? dateFrom,
    String? dateTo,
    double? daysNoTmp,
    bool? payslipPaid,
    String? publicHoliday,
    String? state,
    String? desc,
    List<dynamic>? reviewerIds,
    Map<String, dynamic>? overtimeTypeId,
    double? rateHours,
    String? nextReview,
  }) {
    return Overtime(
      id: id ?? this.id,
      name: name ?? this.name,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      departmentId: departmentId ?? this.departmentId,
      jobId: jobId ?? this.jobId,
      coachId: coachId ?? this.coachId,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      daysNoTmp: daysNoTmp ?? this.daysNoTmp,
      payslipPaid: payslipPaid ?? this.payslipPaid,
      publicHoliday: publicHoliday ?? this.publicHoliday,
      state: state ?? this.state,
      desc: desc ?? this.desc,
      reviewerIds: reviewerIds ?? this.reviewerIds,
      overtimeTypeId: overtimeTypeId ?? this.overtimeTypeId,
      rateHours: rateHours ?? this.rateHours,
      nextReview: nextReview ?? this.nextReview,
    );
  }

  static const List<Overtime> emptyList = [];

  factory Overtime.fromJson(String source) => 
      _$OvertimeFromJson(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(_$OvertimeToJson(this));

  @override
  String toString() {
    return 'Overtime(id: $id, name: $name, employeeId: $employeeId, employeeName: $employeeName, departmentId: $departmentId, jobId: $jobId, coachId: $coachId, dateFrom: $dateFrom, dateTo: $dateTo, daysNoTmp: $daysNoTmp, payslipPaid: $payslipPaid, publicHoliday: $publicHoliday, state: $state, desc: $desc, reviewerIds: $reviewerIds, overtimeTypeId: $overtimeTypeId, rateHours: $rateHours, nextReview: $nextReview)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Overtime &&
        other.id == id &&
        other.name == name &&
        listEquals(other.employeeId, employeeId) &&
        other.employeeName == employeeName &&
        listEquals(other.departmentId, departmentId) &&
        listEquals(other.jobId, jobId) &&
        listEquals(other.coachId, coachId) &&
        other.dateFrom == dateFrom &&
        other.dateTo == dateTo &&
        other.daysNoTmp == daysNoTmp &&
        other.payslipPaid == payslipPaid &&
        other.publicHoliday == publicHoliday &&
        other.state == state &&
        other.desc == desc &&
        listEquals(other.reviewerIds, reviewerIds) &&
        mapEquals(other.overtimeTypeId, overtimeTypeId) &&
        other.rateHours == rateHours &&
        other.nextReview == nextReview;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      id,
      name,
      Object.hashAll(employeeId ?? []),
      employeeName,
      Object.hashAll(departmentId ?? []),
      Object.hashAll(jobId ?? []),
      Object.hashAll(coachId ?? []),
      dateFrom,
      dateTo,
      daysNoTmp,
      payslipPaid,
      publicHoliday,
      state,
      desc,
      Object.hashAll(reviewerIds ?? []),
      Object.hashAll(overtimeTypeId?.entries ?? []),
      rateHours,
      nextReview,
    ]);
  }
}
