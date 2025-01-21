// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

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
    ];

class Attendance {
  int? id;
  int? employee_id;
  String? schedule_in;
  String? check_in;
  String? geo_check_in;
  bool? geo_access_check_in;
  bool? geospatial_access_check_in;
  String? map_url_check_in;
  bool? ismobile_check_in;
  String? check_in_image;
  String? schedule_out;
  String? check_out;
  String? geo_check_out;
  bool? geo_access_check_out;
  bool? geospatial_access_check_out;
  String? map_url_check_out;
  bool? ismobile_check_out;
  String? check_out_image;
  String? desc;
  double? worked_hours;

  Attendance({
    this.id,
    this.employee_id,
    this.schedule_in,
    this.check_in,
    this.geo_check_in,
    this.geo_access_check_in,
    this.geospatial_access_check_in,
    this.map_url_check_in,
    this.ismobile_check_in,
    this.check_in_image,
    this.schedule_out,
    this.check_out,
    this.geo_check_out,
    this.geo_access_check_out,
    this.geospatial_access_check_out,
    this.map_url_check_out,
    this.ismobile_check_out,
    this.check_out_image,
    this.desc,
    this.worked_hours,
  });

  static final List<Attendance> emptyList = [];

  static final empty = Attendance(
    id: 0,
    employee_id: 0,
    schedule_in: "",
    check_in: "",
    geo_check_in: "",
    geo_access_check_in: false,
    geospatial_access_check_in: false,
    map_url_check_in: "",
    ismobile_check_in: false,
    check_in_image: "",
    schedule_out: "",
    check_out: "",
    geo_check_out: "",
    geo_access_check_out: false,
    geospatial_access_check_out: false,
    map_url_check_out: "",
    ismobile_check_out: false,
    check_out_image: "",
    desc: "",
    worked_hours: 0,
  );

  Attendance copyWith({
    int? id,
    int? employee_id,
    String? schedule_in,
    String? check_in,
    String? geo_check_in,
    bool? geo_access_check_in,
    bool? geospatial_access_check_in,
    String? map_url_check_in,
    bool? ismobile_check_in,
    String? check_in_image,
    String? schedule_out,
    String? check_out,
    String? geo_check_out,
    bool? geo_access_check_out,
    bool? geospatial_access_check_out,
    String? map_url_check_out,
    bool? ismobile_check_out,
    String? check_out_image,
    String? desc,
    double? worked_hours,
  }) {
    return Attendance(
      id: id ?? this.id,
      employee_id: employee_id ?? this.employee_id,
      schedule_in: schedule_in ?? this.schedule_in,
      check_in: check_in ?? this.check_in,
      geo_check_in: geo_check_in ?? this.geo_check_in,
      geo_access_check_in: geo_access_check_in ?? this.geo_access_check_in,
      geospatial_access_check_in:
          geospatial_access_check_in ?? this.geospatial_access_check_in,
      map_url_check_in: map_url_check_in ?? this.map_url_check_in,
      ismobile_check_in: ismobile_check_in ?? this.ismobile_check_in,
      check_in_image: check_in_image ?? this.check_in_image,
      schedule_out: schedule_out ?? this.schedule_out,
      check_out: check_out ?? this.check_out,
      geo_check_out: geo_check_out ?? this.geo_check_out,
      geo_access_check_out: geo_access_check_out ?? this.geo_access_check_out,
      geospatial_access_check_out:
          geospatial_access_check_out ?? this.geospatial_access_check_out,
      map_url_check_out: map_url_check_out ?? this.map_url_check_out,
      ismobile_check_out: ismobile_check_out ?? this.ismobile_check_out,
      check_out_image: check_out_image ?? this.check_out_image,
      desc: desc ?? this.desc,
      worked_hours: worked_hours ?? this.worked_hours,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'employee_id': employee_id,
      'schedule_in': schedule_in,
      'check_in': check_in,
      'geo_check_in': geo_check_in,
      'geo_access_check_in': geo_access_check_in,
      'geospatial_access_check_in': geospatial_access_check_in,
      'map_url_check_in': map_url_check_in,
      'ismobile_check_in': ismobile_check_in,
      'check_in_image': check_in_image,
      'schedule_out': schedule_out,
      'check_out': check_out,
      'geo_check_out': geo_check_out,
      'geo_access_check_out': geo_access_check_out,
      'geospatial_access_check_out': geospatial_access_check_out,
      'map_url_check_out': map_url_check_out,
      'ismobile_check_out': ismobile_check_out,
      'check_out_image': check_out_image,
      'desc': desc,
      'worked_hours': worked_hours,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'] != false ? map['id'] as int : null,
      employee_id:
          map['employee_id'] != false ? map['employee_id'][0] as int : null,
      schedule_in:
          map['schedule_in'] != false ? map['schedule_in'] as String : null,
      check_in: map['check_in'] != false ? map['check_in'] as String : null,
      geo_check_in:
          map['geo_check_in'] != false ? map['geo_check_in'] as String : null,
      geo_access_check_in: map['geo_access_check_in'] != false ? true : false,
      geospatial_access_check_in:
          map['geospatial_access_check_in'] != false ? true : false,
      map_url_check_in: map['map_url_check_in'] != false
          ? map['map_url_check_in'] as String
          : null,
      ismobile_check_in: map['ismobile_check_in'] != false ? true : false,
      check_in_image: map['check_in_image'] != false
          ? map['check_in_image'] as String
          : null,
      schedule_out:
          map['schedule_out'] != false ? map['schedule_out'] as String : null,
      check_out: map['check_out'] != false ? map['check_out'] as String : null,
      geo_check_out:
          map['geo_check_out'] != false ? map['geo_check_out'] as String : null,
      geo_access_check_out:
          map['geo_access_check_out'] != false ? true : false,
      geospatial_access_check_out:
          map['geospatial_access_check_out'] != false ? true : false,
      map_url_check_out: map['map_url_check_out'] != false
          ? map['map_url_check_out'] as String
          : null,
      ismobile_check_out: map['ismobile_check_out'] != false ? true : false,
      check_out_image: map['check_out_image'] != false
          ? map['check_out_image'] as String
          : null,
      desc: map['desc'] != false ? map['desc'] as String : null,
      worked_hours:
          map['worked_hours'] != false ? map['worked_hours'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Attendance(id: $id, employee_id: $employee_id, schedule_in: $schedule_in, check_in: $check_in, geo_check_in: $geo_check_in, geo_access_check_in: $geo_access_check_in, geospatial_access_check_in: $geospatial_access_check_in, map_url_check_in: $map_url_check_in, ismobile_check_in: $ismobile_check_in, check_in_image: $check_in_image, schedule_out: $schedule_out, check_out: $check_out, geo_check_out: $geo_check_out, geo_access_check_out: $geo_access_check_out, geospatial_access_check_out: $geospatial_access_check_out, map_url_check_out: $map_url_check_out, ismobile_check_out: $ismobile_check_out, check_out_image: $check_out_image, desc: $desc, worked_hours: $worked_hours)';
  }
}
