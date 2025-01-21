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
      'tz',
      'last_check_in',
      'last_check_out',
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
  String? last_check_in;
  String? last_check_out;

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
    this.last_check_in,
    this.last_check_out,
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
    last_check_in: "",
    last_check_out: "",
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
    String? last_check_in,
    String? last_check_out,
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
      last_check_in: last_check_in ?? this.last_check_in,
      last_check_out: last_check_out ?? this.last_check_out,
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
      'last_check_in': last_check_in,
      'last_check_out': last_check_out,
    };
  }

  

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Employee(id: $id, name: $name, nrp: $nrp, job_id: $job_id, job_title: $job_title, work_email: $work_email, work_phone: $work_phone, address_id: $address_id, parent_id: $parent_id, last_update: $last_update, image_128: $image_128, image_1920: $image_1920, tz: $tz, last_check_in: $last_check_in, last_check_out: $last_check_out)';
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] != false ? map['id'] as int : null,
      name: map['name'] != false ? map['name'] as String : null,
      nrp: map['nrp'] != false ? map['nrp'] as String : null,
      job_id: map['job_id'] != false ? map['job_id'][0] as int : null,
      job_title: map['job_title'] != false ? map['job_title'] as String : null,
      work_email: map['work_email'] != false ? map['work_email'] as String : null,
      work_phone: map['work_phone'] != false ? map['work_phone'] as String : null,
      address_id: map['address_id'] != false ? map['address_id'][1] as String : null,
      parent_id: map['parent_id'] != false ? map['parent_id'][1] as String : null,
      last_update: map['__last_update'] != false ? map['__last_update'] as String : null,
      image_128: map['image_128'] != false ? map['image_128'] as String : null,
      image_1920: map['image_1920'] != false ? map['image_1920'] as String : null,
      tz: map['tz'] != false ? map['tz'] as String : null,
      last_check_in: map['last_check_in'] != false ? map['last_check_in'] as String : null,
      last_check_out: map['last_check_out'] != false ? map['last_check_out'] as String : null,
    );
  }

  @override
  bool operator ==(covariant Employee other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.nrp == nrp &&
      other.job_id == job_id &&
      other.job_title == job_title &&
      other.work_email == work_email &&
      other.work_phone == work_phone &&
      other.address_id == address_id &&
      other.parent_id == parent_id &&
      other.last_update == last_update &&
      other.image_128 == image_128 &&
      other.image_1920 == image_1920 &&
      other.tz == tz &&
      other.last_check_in == last_check_in &&
      other.last_check_out == last_check_out;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      nrp.hashCode ^
      job_id.hashCode ^
      job_title.hashCode ^
      work_email.hashCode ^
      work_phone.hashCode ^
      address_id.hashCode ^
      parent_id.hashCode ^
      last_update.hashCode ^
      image_128.hashCode ^
      image_1920.hashCode ^
      tz.hashCode ^
      last_check_in.hashCode ^
      last_check_out.hashCode;
  }
}
