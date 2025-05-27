import 'package:json_annotation/json_annotation.dart';

part 'timesheet.g.dart';

@JsonSerializable()
class Timesheet {
  const Timesheet({
    required this.id,
    required this.employeeId,
    required this.date,
    required this.projectId,
    required this.taskId,
    required this.name,
    required this.unitAmount,
    required this.projectName,
    required this.taskName,
  });

  final int id;
  @JsonKey(name: 'employee_id')
  final int employeeId;
  final String date;
  @JsonKey(name: 'project_id')
  final int projectId;
  @JsonKey(name: 'task_id')
  final int taskId;
  final String name;
  @JsonKey(name: 'unit_amount')
  final double unitAmount;
  @JsonKey(name: 'project_name')
  final String projectName;
  @JsonKey(name: 'task_name')
  final String taskName;

  static const emptyList = <Timesheet>[];

  factory Timesheet.fromJson(Map<String, dynamic> json) => 
    _$TimesheetFromJson(json);

  Map<String, dynamic> toJson() => _$TimesheetToJson(this);

  @override
  String toString() => 'Timesheet(id: $id, employeeId: $employeeId, date: $date, '
      'projectId: $projectId, taskId: $taskId, name: $name, '
      'unitAmount: $unitAmount, projectName: $projectName, taskName: $taskName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Timesheet &&
        other.id == id &&
        other.employeeId == employeeId &&
        other.date == date &&
        other.projectId == projectId &&
        other.taskId == taskId &&
        other.name == name &&
        other.unitAmount == unitAmount &&
        other.projectName == projectName &&
        other.taskName == taskName;
  }

  @override
  int get hashCode => Object.hash(
        id,
        employeeId,
        date,
        projectId,
        taskId,
        name,
        unitAmount,
        projectName,
        taskName,
      );
} 