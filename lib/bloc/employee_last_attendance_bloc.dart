import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/repository/employee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum EmployeeLastAttendanceStatus { initial, success, error, loading }

extension EmployeeLastAttendanceStatusX on EmployeeLastAttendanceStatus {
  bool get isInitial => this == EmployeeLastAttendanceStatus.initial;
  bool get isSuccess => this == EmployeeLastAttendanceStatus.success;
  bool get isError => this == EmployeeLastAttendanceStatus.error;
  bool get isLoading => this == EmployeeLastAttendanceStatus.loading;
}

class EmployeeLastAttendanceState extends Equatable {
  EmployeeLastAttendanceState({
    this.status = EmployeeLastAttendanceStatus.initial,
    Employee? employee,
  }) : employee = employee ?? Employee.empty;

  final Employee employee;
  final EmployeeLastAttendanceStatus status;

  @override
  List<Object?> get props => [status, employee];

  EmployeeLastAttendanceState copyWith({
    Employee? employee,
    EmployeeLastAttendanceStatus? status,
  }) {
    return EmployeeLastAttendanceState(
      employee: employee ?? this.employee,
      status: status ?? this.status,
    );
  }
}

class EmployeeLastAttendanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetEmployeeLastAttendance extends EmployeeLastAttendanceEvent {
  @override
  List<Object?> get props => [];
}

class EmployeeLastAttendanceBloc
    extends Bloc<EmployeeLastAttendanceEvent, EmployeeLastAttendanceState> {
  EmployeeLastAttendanceBloc({
    required this.employeeRepository,
  }) : super(EmployeeLastAttendanceState()) {
    on<GetEmployeeLastAttendance>(_mapGetEmployeeLastAttendanceEventToState);
  }

  final EmployeeRepository employeeRepository;

  void _mapGetEmployeeLastAttendanceEventToState(
      GetEmployeeLastAttendance event,
      Emitter<EmployeeLastAttendanceState> emit) async {
    try {
      emit(state.copyWith(status: EmployeeLastAttendanceStatus.loading));
      Map<String, dynamic> result = await employeeRepository.getEmployee();
      Employee employee = result["data"];
      emit(
        state.copyWith(
          status: EmployeeLastAttendanceStatus.success,
          employee: employee,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: EmployeeLastAttendanceStatus.error));
    }
  }
}
