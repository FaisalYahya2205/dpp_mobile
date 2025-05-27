import 'package:dpp_mobile/models/survey.dart';
import 'package:dpp_mobile/models/survey_post.dart';
import 'package:dpp_mobile/repository/attendance_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "survey_event.dart";
part "survey_state.dart";

class CheckInSurveyBloc extends Bloc<CheckInSurveyEvent, CheckInSurveyState> {
  CheckInSurveyBloc({
    required this.attendanceRepository,
  }) : super(const CheckInSurveyState()) {
    on<GetCheckInSurvey>(_mapGetCheckInSurveyEventToState);
    on<SelectSurveyAnswer>(_mapSelectSurveyAnswerEventToState);
    on<SubmitSurvey>(_mapSubmitSurveyEventToState);
  }

  final AttendanceRepository attendanceRepository;

  Future<void> _mapGetCheckInSurveyEventToState(
    GetCheckInSurvey event,
    Emitter<CheckInSurveyState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CheckInSurveyStatus.loading));
      
      final result = await attendanceRepository.getCheckInSurvey();
      debugPrint("result: $result");
      
      if (result["success"] == true) {
        final surveyQuestions = result["data"] as Survey;
        emit(state.copyWith(
          status: CheckInSurveyStatus.success,
          surveyQuestions: surveyQuestions,
          errorMessage: '',
        ));
      } else {
        emit(state.copyWith(
          status: CheckInSurveyStatus.error,
          errorMessage: result["errorMessage"] as String,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: CheckInSurveyStatus.error,
        errorMessage: 'Failed to fetch survey questions',
      ));
    }
  }

  void _mapSelectSurveyAnswerEventToState(
    SelectSurveyAnswer event,
    Emitter<CheckInSurveyState> emit,
  ) {
    if (state.status != CheckInSurveyStatus.success) return;

    final updatedQuestions = state.surveyQuestions.questions?.map((question) {
      if (question.id == event.questionId) {
        // Deselect all other answers for this question
        final updatedAnswers = question.answer?.map((answer) {
          return answer.copyWith(isSelected: answer.id == event.answer.id);
        }).toList();

        return question.copyWith(
          answer: updatedAnswers,
          selectedAnswer: event.answer,
        );
      }
      return question;
    }).toList();

    final updatedSurvey = state.surveyQuestions.copyWith(
      questions: updatedQuestions,
      isCompleted: updatedQuestions?.every((q) => q.selectedAnswer != null) ?? false,
    );

    emit(state.copyWith(surveyQuestions: updatedSurvey));
  }

  Future<void> _mapSubmitSurveyEventToState(
    SubmitSurvey event,
    Emitter<CheckInSurveyState> emit,
  ) async {
    if (!state.surveyQuestions.allQuestionsAnswered) {
      emit(state.copyWith(
        status: CheckInSurveyStatus.error,
        errorMessage: 'Please answer all questions before submitting',
      ));
      return;
    }

    try {
      emit(state.copyWith(status: CheckInSurveyStatus.loading));

      // Create survey post data
      final surveyPost = SurveyPost(
        surveyId: state.surveyQuestions.id ?? 0,
        partnerId: event.partnerId,
        userInputLineIds: state.surveyQuestions.questions?.map((question) {
          final selectedAnswer = question.selectedAnswer;
          return {
            'user_input_id': event.userInputId,
            'survey_id': state.surveyQuestions.id ?? 0,
            'question_id': question.id ?? 0,
            'question_sequence': question.sequence ?? 0,
            'answer_type': selectedAnswer?.value == null ? "text_box" : "suggestion",
            'suggested_answer_id': selectedAnswer?.id,
            'value_text_box': selectedAnswer?.value ?? selectedAnswer?.value,
            'answer_score': 0,
            'matrix_row_id': question.id ?? 0
          };
        }).toList() ?? [],
      );

      debugPrint(surveyPost.toJson());

      // Submit survey
      final result = await attendanceRepository.submitSurvey(surveyPost, event.attendanceId);
      
      if (result["success"] == true) {
        emit(state.copyWith(
          status: CheckInSurveyStatus.success,
          submitSuccess: true,
          errorMessage: '',
        ));
      } else {
        emit(state.copyWith(
          status: CheckInSurveyStatus.error,
          errorMessage: result["errorMessage"] as String,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: CheckInSurveyStatus.error,
        errorMessage: 'Failed to submit survey',
      ));
    }
  }
}
