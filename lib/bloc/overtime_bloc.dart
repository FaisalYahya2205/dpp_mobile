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
  OvertimeState({
    this.status = OvertimeStatus.initial,
    List<Overtime>? overtimes,
  }) : overtimes = overtimes ?? Overtime.emptyList;

  final List<Overtime> overtimes;
  final OvertimeStatus status;

  @override
  List<Object?> get props => [status, overtimes];

  OvertimeState copyWith({
    List<Overtime>? overtimes,
    OvertimeStatus? status,
  }) {
    return OvertimeState(
      overtimes: overtimes,
      status: status ?? this.status,
    );
  }
}

class OvertimeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetOvertimeList extends OvertimeEvent {
  GetOvertimeList({
    required this.overtimeState,
  });

  final String overtimeState;
  @override
  List<Object?> get props => [overtimeState];
}

class OvertimeBloc extends Bloc<OvertimeEvent, OvertimeState> {
  OvertimeBloc({
    required this.overtimeRepository,
  }) : super(OvertimeState()) {
    on<GetOvertimeList>(_mapGetOvertimeListEventToState);
  }

  final OvertimeRepository overtimeRepository;

  void _mapGetOvertimeListEventToState(
      GetOvertimeList event, Emitter<OvertimeState> emit) async {
    try {
      emit(state.copyWith(status: OvertimeStatus.loading));
      Map<String, dynamic> result =
          await overtimeRepository.getOvertimeList(event.overtimeState);
      List<Overtime> overtime = result["data"];
      emit(
        state.copyWith(
          status: OvertimeStatus.success,
          overtimes: overtime,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: OvertimeStatus.error));
    }
  }
}
