// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: non_constant_identifier_names

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

class Overtime {
  int? id;
  String? name;
  List<dynamic>? employee_id;
  String? employee_name;
  List<dynamic>? department_id;
  List<dynamic>? job_id;
  List<dynamic>? coach_id;
  String? date_from;
  String? date_to;
  double? days_no_tmp;
  bool? payslip_paid;
  String? public_holiday;
  String? state;
  String? desc;
  List<dynamic>? reviewer_ids;
  Map<String, dynamic>? overtime_type_id;
  double? rate_hours;
  String? next_review;

  Overtime({
    this.id,
    this.name,
    this.employee_id,
    this.employee_name,
    this.department_id,
    this.job_id,
    this.coach_id,
    this.date_from,
    this.date_to,
    this.days_no_tmp,
    this.payslip_paid,
    this.public_holiday,
    this.state,
    this.desc,
    this.reviewer_ids,
    this.overtime_type_id,
    this.rate_hours,
    this.next_review,
  });

  Overtime copyWith({
    int? id,
    String? name,
    List<dynamic>? employee_id,
    String? employee_name,
    List<dynamic>? department_id,
    List<dynamic>? job_id,
    List<dynamic>? coach_id,
    String? date_from,
    String? date_to,
    double? days_no_tmp,
    bool? payslip_paid,
    String? public_holiday,
    String? state,
    String? desc,
    List<dynamic>? reviewer_ids,
    Map<String, dynamic>? overtime_type_id,
    double? rate_hours,
    String? next_review,
  }) {
    return Overtime(
      id: id ?? this.id,
      name: name ?? this.name,
      employee_id: employee_id ?? this.employee_id,
      employee_name: employee_name ?? this.employee_name,
      department_id: department_id ?? this.department_id,
      job_id: job_id ?? this.job_id,
      coach_id: coach_id ?? this.coach_id,
      date_from: date_from ?? this.date_from,
      date_to: date_to ?? this.date_to,
      days_no_tmp: days_no_tmp ?? this.days_no_tmp,
      payslip_paid: payslip_paid ?? this.payslip_paid,
      public_holiday: public_holiday ?? this.public_holiday,
      state: state ?? this.state,
      desc: desc ?? this.desc,
      reviewer_ids: reviewer_ids ?? this.reviewer_ids,
      overtime_type_id: overtime_type_id ?? this.overtime_type_id,
      rate_hours: rate_hours ?? this.rate_hours,
      next_review: next_review ?? this.next_review,
    );
  }

  static final List<Overtime> emptyList = [];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'employee_id': employee_id,
      'employee_name': employee_name,
      'department_id': department_id,
      'job_id': job_id,
      'coach_id': coach_id,
      'date_from': date_from,
      'date_to': date_to,
      'days_no_tmp': days_no_tmp,
      'payslip_paid': payslip_paid,
      'public_holiday': public_holiday,
      'state': state,
      'desc': desc,
      'reviewer_ids': reviewer_ids,
      'overtime_type_id': overtime_type_id,
      'rate_hours': rate_hours,
    };
  }

  factory Overtime.fromMap(Map<String, dynamic> map) {
    return Overtime(
      id: map['id'] != false ? map['id'] as int : null,
      name: map['name'] != false ? map['name'] as String : null,
      employee_id: map['employee_id'] != false
          ? List<dynamic>.from((map['employee_id'] as List<dynamic>))
          : null,
      employee_name:
          map['employee_name'] != false ? map['employee_name'] as String : null,
      department_id: map['department_id'] != false
          ? List<dynamic>.from((map['department_id'] as List<dynamic>))
          : null,
      job_id: map['job_id'] != false
          ? List<dynamic>.from((map['job_id'] as List<dynamic>))
          : null,
      coach_id: map['coach_id'] != false
          ? List<dynamic>.from((map['coach_id'] as List<dynamic>))
          : null,
      date_from: map['date_from'] != false ? map['date_from'] as String : null,
      date_to: map['date_to'] != false ? map['date_to'] as String : null,
      days_no_tmp:
          map['days_no_tmp'] != false ? map['days_no_tmp'] as double : null,
      payslip_paid:
          map['payslip_paid'] != false ? map['payslip_paid'] as bool : null,
      public_holiday: map['public_holiday'] != false
          ? map['public_holiday'] as String
          : null,
      state: map['state'] != false ? map['state'] as String : null,
      desc: map['desc'] != false ? map['desc'] as String : null,
      reviewer_ids: map['reviewer_ids'] != false
          ? map['reviewer_ids'] as List<dynamic>
          : null,
      overtime_type_id: map['overtime_type_id'] != false
          ? map['overtime_type_id'] as Map<String, dynamic>
          : null,
      rate_hours:
          map['rate_hours'] != false ? map['rate_hours'] as double : null,
      next_review: map['next_review'] != false && map['next_review'] != ""
          ? map['next_review'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Overtime.fromJson(String source) =>
      Overtime.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Overtime(id: $id, name: $name, employee_id: $employee_id, employee_name: $employee_name, department_id: $department_id, job_id: $job_id, coach_id: $coach_id, date_from: $date_from, date_to: $date_to, days_no_tmp: $days_no_tmp, payslip_paid: $payslip_paid, public_holiday: $public_holiday, state: $state, desc: $desc, reviewer_ids: $reviewer_ids, overtime_type_id: $overtime_type_id, rate_hours: $rate_hours, next_review: $next_review)';
  }

  @override
  bool operator ==(covariant Overtime other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.employee_id, employee_id) &&
        other.employee_name == employee_name &&
        listEquals(other.department_id, department_id) &&
        listEquals(other.job_id, job_id) &&
        listEquals(other.coach_id, coach_id) &&
        other.date_from == date_from &&
        other.date_to == date_to &&
        other.days_no_tmp == days_no_tmp &&
        other.payslip_paid == payslip_paid &&
        other.public_holiday == public_holiday &&
        other.state == state &&
        other.desc == desc &&
        listEquals(other.reviewer_ids, reviewer_ids) &&
        mapEquals(other.overtime_type_id, overtime_type_id) &&
        other.rate_hours == rate_hours &&
        other.next_review == next_review;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        employee_id.hashCode ^
        employee_name.hashCode ^
        department_id.hashCode ^
        job_id.hashCode ^
        coach_id.hashCode ^
        date_from.hashCode ^
        date_to.hashCode ^
        days_no_tmp.hashCode ^
        payslip_paid.hashCode ^
        public_holiday.hashCode ^
        state.hashCode ^
        desc.hashCode ^
        reviewer_ids.hashCode ^
        overtime_type_id.hashCode ^
        rate_hours.hashCode ^
        next_review.hashCode;
  }
}
