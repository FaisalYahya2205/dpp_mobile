// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

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
      'tz'
    ];

@JsonSerializable(fieldRename: FieldRename.snake)
class Employee {
  int? id;
  String? name;
  String? nrp;
  int? job_id;
  String? job_title;
  String? work_email;
  String? work_phone;
  String? address_id;
  String? parent_id;
  String? last_update;
  String? image_128;
  String? image_1920;
  String? tz;

  Employee({
    this.id,
    this.name,
    this.nrp,
    this.job_id,
    this.job_title,
    this.work_email,
    this.work_phone,
    this.address_id,
    this.parent_id,
    this.last_update,
    this.image_128,
    this.image_1920,
    this.tz,
  });

  static final empty = Employee(
    id: 0,
    name: "",
    nrp: "",
    job_id: 0,
    job_title: "",
    work_email: "",
    work_phone: "",
    address_id: "",
    parent_id: "",
    last_update: "",
    image_128: "",
    image_1920: "",
    tz: "",
  );

  Employee copyWith({
    int? id,
    String? name,
    String? nrp,
    int? job_id,
    String? job_title,
    String? work_email,
    String? work_phone,
    String? address_id,
    String? parent_id,
    String? last_update,
    String? image_128,
    String? image_1920,
    String? tz,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      nrp: nrp ?? this.nrp,
      job_id: job_id ?? this.job_id,
      job_title: job_title ?? this.job_title,
      work_email: work_email ?? this.work_email,
      work_phone: work_phone ?? this.work_phone,
      address_id: address_id ?? this.address_id,
      parent_id: parent_id ?? this.parent_id,
      last_update: last_update ?? this.last_update,
      image_128: image_128 ?? this.image_128,
      image_1920: image_1920 ?? this.image_1920,
      tz: tz ?? this.tz,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'nrp': nrp,
      'job_id': job_id,
      'job_title': job_title,
      'work_email': work_email,
      'work_phone': work_phone,
      'address_id': address_id,
      'parent_id': parent_id,
      '__last_update': last_update,
      'image_128': image_128,
      'image_1920': image_1920,
      'tz': tz,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as int,
      name: map['name'] as String,
      nrp: map['nrp'] as String,
      job_id: map['job_id'][0] as int,
      job_title: map['job_title'] as String,
      work_email: map['work_email'] as String,
      work_phone: map['work_phone'] as String,
      address_id: map['address_id'][1] as String,
      parent_id: map['parent_id'][1] as String,
      last_update: map['__last_update'] as String,
      image_128: map['image_128'] as String,
      image_1920: map['image_1920'] as String,
      tz: map['tz'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Employee(id: $id, name: $name, nrp: $nrp, job_id: $job_id, job_title: $job_title, work_email: $work_email, work_phone: $work_phone, address_id: $address_id, parent_id: $parent_id, __last_update: $last_update, image_128: $image_128, image_1920: $image_1920, tz: $tz)';
  }
}
