import 'package:dpp_mobile/models/employee.dart';
import 'package:dpp_mobile/repository/employee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum EmployeeStatus { initial, success, error, loading }

extension EmployeeStatusX on EmployeeStatus {
  bool get isInitial => this == EmployeeStatus.initial;
  bool get isSuccess => this == EmployeeStatus.success;
  bool get isError => this == EmployeeStatus.error;
  bool get isLoading => this == EmployeeStatus.loading;
}

class EmployeeState extends Equatable {
  const EmployeeState({
    this.status = EmployeeStatus.initial,
    this.employee = Employee.empty,
    this.errorMessage = '',
  });

  final Employee employee;
  final EmployeeStatus status;
  final String errorMessage;

  @override
  List<Object?> get props => [status, employee, errorMessage];

  EmployeeState copyWith({
    Employee? employee,
    EmployeeStatus? status,
    String? errorMessage,
  }) {
    return EmployeeState(
      employee: employee ?? this.employee,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object?> get props => [];
}

class GetEmployee extends EmployeeEvent {
  const GetEmployee();
}

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc({
    required this.employeeRepository,
  }) : super(const EmployeeState()) {
    on<GetEmployee>(_mapGetEmployeeEventToState);
  }

  final EmployeeRepository employeeRepository;

  Future<void> _mapGetEmployeeEventToState(
    GetEmployee event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: EmployeeStatus.loading));
      
      final result = await employeeRepository.getEmployee();
      
      if (result["success"] == true) {
        final employee = result["data"] as Employee;
        emit(state.copyWith(
          status: EmployeeStatus.success,
          employee: employee,
          errorMessage: '',
        ));
      } else {
        emit(state.copyWith(
          status: EmployeeStatus.error,
          errorMessage: result["errorMessage"] as String,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: EmployeeStatus.error,
        errorMessage: 'Failed to fetch employee data',
      ));
    }
  }
}
