// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

/// List of field names used in the Employee model
List<String> getEmployeeFields() => [
      'id',
      'name',
      'nrp',
      'job_id',
      'job_title',
      'work_email',
      'work_phone',
      'address_id',
      'parent_id',
      '__last_update',
      'image_128',
      'image_1920',
      'tz',
      'last_check_in',
      'last_check_out',
    ];

/// Model class representing an employee
@JsonSerializable(fieldRename: FieldRename.snake)
class Employee {
  final int? id;
  final String? name;
  final String? nrp;
  final int? jobId;
  final String? jobTitle;
  final String? workEmail;
  final String? workPhone;
  final String? addressId;
  final String? parentId;
  final String? lastUpdate;
  final String? image128;
  final String? image1920;
  final String? tz;
  final String? lastCheckIn;
  final String? lastCheckOut;

  const Employee({
    this.id,
    this.name,
    this.nrp,
    this.jobId,
    this.jobTitle,
    this.workEmail,
    this.workPhone,
    this.addressId,
    this.parentId,
    this.lastUpdate,
    this.image128,
    this.image1920,
    this.tz,
    this.lastCheckIn,
    this.lastCheckOut,
  });

  static const empty = Employee(
    id: 0,
    name: "",
    nrp: "",
    jobId: 0,
    jobTitle: "",
    workEmail: "",
    workPhone: "",
    addressId: "",
    parentId: "",
    lastUpdate: "",
    image128: "",
    image1920: "",
    tz: "",
    lastCheckIn: "",
    lastCheckOut: "",
  );

  Employee copyWith({
    int? id,
    String? name,
    String? nrp,
    int? jobId,
    String? jobTitle,
    String? workEmail,
    String? workPhone,
    String? addressId,
    String? parentId,
    String? lastUpdate,
    String? image128,
    String? image1920,
    String? tz,
    String? lastCheckIn,
    String? lastCheckOut,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      nrp: nrp ?? this.nrp,
      jobId: jobId ?? this.jobId,
      jobTitle: jobTitle ?? this.jobTitle,
      workEmail: workEmail ?? this.workEmail,
      workPhone: workPhone ?? this.workPhone,
      addressId: addressId ?? this.addressId,
      parentId: parentId ?? this.parentId,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      image128: image128 ?? this.image128,
      image1920: image1920 ?? this.image1920,
      tz: tz ?? this.tz,
      lastCheckIn: lastCheckIn ?? this.lastCheckIn,
      lastCheckOut: lastCheckOut ?? this.lastCheckOut,
    );
  }

  factory Employee.fromJson(String source) => 
      _$EmployeeFromJson(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(_$EmployeeToJson(this));

  @override
  String toString() {
    return 'Employee(id: $id, name: $name, nrp: $nrp, jobId: $jobId, jobTitle: $jobTitle, workEmail: $workEmail, workPhone: $workPhone, addressId: $addressId, parentId: $parentId, lastUpdate: $lastUpdate, image128: $image128, image1920: $image1920, tz: $tz, lastCheckIn: $lastCheckIn, lastCheckOut: $lastCheckOut)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Employee &&
        other.id == id &&
        other.name == name &&
        other.nrp == nrp &&
        other.jobId == jobId &&
        other.jobTitle == jobTitle &&
        other.workEmail == workEmail &&
        other.workPhone == workPhone &&
        other.addressId == addressId &&
        other.parentId == parentId &&
        other.lastUpdate == lastUpdate &&
        other.image128 == image128 &&
        other.image1920 == image1920 &&
        other.tz == tz &&
        other.lastCheckIn == lastCheckIn &&
        other.lastCheckOut == lastCheckOut;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      id,
      name,
      nrp,
      jobId,
      jobTitle,
      workEmail,
      workPhone,
      addressId,
      parentId,
      lastUpdate,
      image128,
      image1920,
      tz,
      lastCheckIn,
      lastCheckOut,
    ]);
  }
}
