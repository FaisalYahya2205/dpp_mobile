part of 'survey_bloc.dart';

enum CheckInSurveyStatus {
  initial,
  success,
  error,
  loading,
}

extension CheckInSurveyStatusX on CheckInSurveyStatus {
  bool get isInitial => this == CheckInSurveyStatus.initial;
  bool get isSuccess => this == CheckInSurveyStatus.success;
  bool get isError => this == CheckInSurveyStatus.error;
  bool get isLoading => this == CheckInSurveyStatus.loading;
}

class CheckInSurveyState extends Equatable {
  const CheckInSurveyState({
    this.status = CheckInSurveyStatus.initial,
    this.surveyQuestions = Survey.empty,
    this.submitSuccess = false,
    this.errorMessage = '',
  });

  final Survey surveyQuestions;
  final CheckInSurveyStatus status;
  final bool submitSuccess;
  final String errorMessage;

  @override
  List<Object?> get props => [
        status,
        surveyQuestions,
        submitSuccess,
        errorMessage,
      ];

  CheckInSurveyState copyWith({
    Survey? surveyQuestions,
    CheckInSurveyStatus? status,
    bool? submitSuccess,
    String? errorMessage,
  }) {
    return CheckInSurveyState(
      surveyQuestions: surveyQuestions ?? this.surveyQuestions,
      status: status ?? this.status,
      submitSuccess: submitSuccess ?? this.submitSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
