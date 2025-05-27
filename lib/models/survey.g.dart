// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyAnswer _$SurveyAnswerFromJson(Map<String, dynamic> json) => SurveyAnswer(
      id: json['id'] == false ? null : (json['id'] as num?)?.toInt(),
      sequence: json['sequence'] == false ? null : (json['sequence'] as num?)?.toInt(),
      questionId: json['question_id'] == false ? null : (json['question_id'] as num?)?.toInt(),
      value: json['value'] == false ? null : json['value'] as String?,
      answerScore: json['answer_score'] == false ? null : (json['answer_score'] as num?)?.toDouble(),
      isSelected: json['is_selected'] == false ? false : json['is_selected'] as bool,
    );

Map<String, dynamic> _$SurveyAnswerToJson(SurveyAnswer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sequence': instance.sequence,
      'question_id': instance.questionId,
      'value': instance.value,
      'answer_score': instance.answerScore,
      'is_selected': instance.isSelected,
    };

SurveyQuestion _$SurveyQuestionFromJson(Map<String, dynamic> json) =>
    SurveyQuestion(
      id: (json['id'] as num?)?.toInt(),
      sequence: (json['sequence'] as num?)?.toInt(),
      title: json['title'] as String?,
      answer: (json['answer'] as List<dynamic>?)
          ?.map((e) => SurveyAnswer.fromJson(e as String))
          .toList(),
      selectedAnswer: json['selected_answer'] == null
          ? null
          : SurveyAnswer.fromJson(json['selected_answer'] as String),
    );

Map<String, dynamic> _$SurveyQuestionToJson(SurveyQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sequence': instance.sequence,
      'title': instance.title,
      'answer': instance.answer,
      'selected_answer': instance.selectedAnswer,
    };

Survey _$SurveyFromJson(Map<String, dynamic> json) => Survey(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => SurveyQuestion.fromJson(e as String))
          .toList(),
      isCompleted: json['is_completed'] as bool? ?? false,
    );

Map<String, dynamic> _$SurveyToJson(Survey instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'questions': instance.questions,
      'is_completed': instance.isCompleted,
    };
