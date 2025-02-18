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
  EmployeeState({
    this.status = EmployeeStatus.initial,
    Employee? employee,
  }) : employee = employee ?? Employee.empty;

  final Employee employee;
  final EmployeeStatus status;

  @override
  List<Object?> get props => [status, employee];

  EmployeeState copyWith({
    Employee? employee,
    EmployeeStatus? status,
  }) {
    return EmployeeState(
      employee: employee ?? this.employee,
      status: status ?? this.status,
    );
  }
}

class EmployeeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetEmployee extends EmployeeEvent {
  @override
  List<Object?> get props => [];
}

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc({
    required this.employeeRepository,
  }) : super(EmployeeState()) {
    on<GetEmployee>(_mapGetEmployeeEventToState);
  }

  final EmployeeRepository employeeRepository;

  void _mapGetEmployeeEventToState(
      GetEmployee event, Emitter<EmployeeState> emit) async {
    try {
      emit(state.copyWith(status: EmployeeStatus.loading));
      Map<String, dynamic> result = await employeeRepository.getEmployee();
      Employee employee = result["data"];
      emit(
        state.copyWith(
          status: EmployeeStatus.success,
          employee: employee,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: EmployeeStatus.error));
    }
  }
}
