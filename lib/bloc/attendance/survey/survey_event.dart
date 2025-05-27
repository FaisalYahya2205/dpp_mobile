part of 'survey_bloc.dart';

abstract class CheckInSurveyEvent extends Equatable {
  const CheckInSurveyEvent();

  @override
  List<Object?> get props => [];
}

class GetCheckInSurvey extends CheckInSurveyEvent {
  const GetCheckInSurvey();

  @override
  List<Object?> get props => [];
}

class SelectSurveyAnswer extends CheckInSurveyEvent {
  const SelectSurveyAnswer({
    required this.questionId,
    required this.answer,
  });

  final int questionId;
  final SurveyAnswer answer;

  @override
  List<Object?> get props => [questionId, answer];
}

class SubmitSurvey extends CheckInSurveyEvent {
  const SubmitSurvey({
    required this.partnerId,
    required this.userInputId,
    required this.attendanceId,
  });

  final int partnerId;
  final int userInputId;
  final int attendanceId;

  @override
  List<Object?> get props => [partnerId, userInputId, attendanceId];
}