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
  const EmployeeLastAttendanceState({
    this.status = EmployeeLastAttendanceStatus.initial,
    this.employee = Employee.empty,
    this.errorMessage = '',
  });

  final Employee employee;
  final EmployeeLastAttendanceStatus status;
  final String errorMessage;

  @override
  List<Object?> get props => [status, employee, errorMessage];

  EmployeeLastAttendanceState copyWith({
    Employee? employee,
    EmployeeLastAttendanceStatus? status,
    String? errorMessage,
  }) {
    return EmployeeLastAttendanceState(
      employee: employee ?? this.employee,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

abstract class EmployeeLastAttendanceEvent extends Equatable {
  const EmployeeLastAttendanceEvent();

  @override
  List<Object?> get props => [];
}

class GetEmployeeLastAttendance extends EmployeeLastAttendanceEvent {
  const GetEmployeeLastAttendance();
}

class EmployeeLastAttendanceBloc
    extends Bloc<EmployeeLastAttendanceEvent, EmployeeLastAttendanceState> {
  EmployeeLastAttendanceBloc({
    required this.employeeRepository,
  }) : super(const EmployeeLastAttendanceState()) {
    on<GetEmployeeLastAttendance>(_mapGetEmployeeLastAttendanceEventToState);
  }

  final EmployeeRepository employeeRepository;

  Future<void> _mapGetEmployeeLastAttendanceEventToState(
    GetEmployeeLastAttendance event,
    Emitter<EmployeeLastAttendanceState> emit,
  ) async {
    try {
      emit(state.copyWith(status: EmployeeLastAttendanceStatus.loading));
      
      final result = await employeeRepository.getEmployee();
      
      if (result["success"] == true) {
        final employee = result["data"] as Employee;
        emit(state.copyWith(
          status: EmployeeLastAttendanceStatus.success,
          employee: employee,
          errorMessage: '',
        ));
      } else {
        emit(state.copyWith(
          status: EmployeeLastAttendanceStatus.error,
          errorMessage: result["errorMessage"] as String,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: EmployeeLastAttendanceStatus.error,
        errorMessage: 'Failed to fetch employee data',
      ));
    }
  }
}
