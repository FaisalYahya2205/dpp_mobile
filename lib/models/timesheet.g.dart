// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timesheet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timesheet _$TimesheetFromJson(Map<String, dynamic> json) => Timesheet(
      id: json['id'] == false ? 0 : (json['id'] as num).toInt(),
      employeeId: json['employee_id'] == false ? 0 : (json['employee_id'] as num).toInt(),
      date: json['date'] == false ? "" : json['date'] as String,
      projectId: json['project_id'] == false ? 0 : (json['project_id'] as num).toInt(),
      taskId: json['task_id'] == false ? 0 : (json['task_id'] as num).toInt(),
      name: json['name'] == false ? "" : json['name'] as String,
      unitAmount: json['unit_amount'] == false ? 0 : (json['unit_amount'] as num).toDouble(),
      projectName: json['project_name'] == false ? "" : json['project_name'] as String,
      taskName: json['task_name'] == false ? "" : json['task_name'] as String,
    );

Map<String, dynamic> _$TimesheetToJson(Timesheet instance) => <String, dynamic>{
      'id': instance.id,
      'employee_id': instance.employeeId,
      'date': instance.date,
      'project_id': instance.projectId,
      'task_id': instance.taskId,
      'name': instance.name,
      'unit_amount': instance.unitAmount,
      'project_name': instance.projectName,
      'task_name': instance.taskName,
    };
