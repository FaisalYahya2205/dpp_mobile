import 'package:dpp_mobile/models/overtime.dart';
import 'package:dpp_mobile/repository/overtime_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum OvertimeStatus { initial, success, error, loading }

extension OvertimeStatusX on OvertimeStatus {
  bool get isInitial => this == OvertimeStatus.initial;
  bool get isSuccess => this == OvertimeStatus.success;
  bool get isError => this == OvertimeStatus.error;
  bool get isLoading => this == OvertimeStatus.loading;
}

class OvertimeState extends Equatable {
  const OvertimeState({
    this.status = OvertimeStatus.initial,
    this.overtimes = Overtime.emptyList,
    this.errorMessage = '',
  });

  final List<Overtime> overtimes;
  final OvertimeStatus status;
  final String errorMessage;

  @override
  List<Object?> get props => [status, overtimes, errorMessage];

  OvertimeState copyWith({
    List<Overtime>? overtimes,
    OvertimeStatus? status,
    String? errorMessage,
  }) {
    return OvertimeState(
      overtimes: overtimes ?? this.overtimes,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

abstract class OvertimeEvent extends Equatable {
  const OvertimeEvent();

  @override
  List<Object?> get props => [];
}

class GetOvertimeList extends OvertimeEvent {
  const GetOvertimeList({
    required this.overtimeState,
  });

  final String overtimeState;

  @override
  List<Object?> get props => [overtimeState];
}

class OvertimeBloc extends Bloc<OvertimeEvent, OvertimeState> {
  OvertimeBloc({
    required this.overtimeRepository,
  }) : super(const OvertimeState()) {
    on<GetOvertimeList>(_mapGetOvertimeListEventToState);
  }

  final OvertimeRepository overtimeRepository;

  Future<void> _mapGetOvertimeListEventToState(
    GetOvertimeList event,
    Emitter<OvertimeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: OvertimeStatus.loading));
      
      final result = await overtimeRepository.getOvertimeList(event.overtimeState);
      
      if (result["success"] == true) {
        final overtimes = result["data"] as List<Overtime>;
        emit(state.copyWith(
          status: OvertimeStatus.success,
          overtimes: overtimes,
          errorMessage: '',
        ));
      } else {
        emit(state.copyWith(
          status: OvertimeStatus.error,
          errorMessage: result["errorMessage"] as String,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: OvertimeStatus.error,
        errorMessage: 'Failed to fetch overtime list',
      ));
    }
  }
}
