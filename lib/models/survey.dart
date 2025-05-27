import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'survey.g.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

/// List of field names used in the Survey model
List<String> getSurveyFields() => ['id', 'title', 'questions'];

/// List of field names used in the SurveyQuestion model
List<String> getSurveyQuestionFields() => [
      'id',
      'sequence',
      'title',
    ];

/// List of field names used in the SurveyAnswer model
List<String> getSurveyAnswerFields() => [
      'id',
      'sequence',
      'question_id',
      'value',
      'answer_score',
    ];

/// Model class representing a survey answer
@JsonSerializable(fieldRename: FieldRename.snake)
class SurveyAnswer {
  final int? id;
  final int? sequence;
  final int? questionId;
  final String? value;
  final double? answerScore;
  final bool isSelected;

  const SurveyAnswer({
    this.id,
    this.sequence,
    this.questionId,
    this.value,
    this.answerScore,
    this.isSelected = false,
  });

  SurveyAnswer copyWith({
    int? id,
    int? sequence,
    int? questionId,
    String? value,
    double? answerScore,
    bool? isSelected,
  }) {
    return SurveyAnswer(
      id: id ?? this.id,
      sequence: sequence ?? this.sequence,
      questionId: questionId ?? this.questionId,
      value: value ?? this.value,
      answerScore: answerScore ?? this.answerScore,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory SurveyAnswer.fromJson(String source) => 
      _$SurveyAnswerFromJson(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(_$SurveyAnswerToJson(this));

  @override
  String toString() {
    return 'SurveyAnswer(id: $id, sequence: $sequence, questionId: $questionId, value: $value, answerScore: $answerScore, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SurveyAnswer &&
        other.id == id &&
        other.sequence == sequence &&
        other.questionId == questionId &&
        other.value == value &&
        other.answerScore == answerScore &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      id,
      sequence,
      questionId,
      value,
      answerScore,
      isSelected,
    ]);
  }
}

/// Model class representing a survey question
@JsonSerializable(fieldRename: FieldRename.snake)
class SurveyQuestion {
  final int? id;
  final int? sequence;
  final String? title;
  final List<SurveyAnswer>? answer;
  final SurveyAnswer? selectedAnswer;

  static const List<SurveyQuestion> emptyList = [];

  const SurveyQuestion({
    this.id,
    this.sequence,
    this.title,
    this.answer,
    this.selectedAnswer,
  });

  SurveyQuestion copyWith({
    int? id,
    int? sequence,
    String? title,
    List<SurveyAnswer>? answer,
    SurveyAnswer? selectedAnswer,
  }) {
    return SurveyQuestion(
      id: id ?? this.id,
      sequence: sequence ?? this.sequence,
      title: title ?? this.title,
      answer: answer ?? this.answer,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }

  factory SurveyQuestion.fromJson(String source) => 
      _$SurveyQuestionFromJson(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(_$SurveyQuestionToJson(this));

  @override
  String toString() {
    return 'SurveyQuestion(id: $id, sequence: $sequence, title: $title, answer: $answer, selectedAnswer: $selectedAnswer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SurveyQuestion &&
        other.id == id &&
        other.sequence == sequence &&
        other.title == title &&
        listEquals(other.answer, answer) &&
        other.selectedAnswer == selectedAnswer;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      id,
      sequence,
      title,
      Object.hashAll(answer ?? []),
      selectedAnswer,
    ]);
  }
}

/// Model class representing a survey
@JsonSerializable(fieldRename: FieldRename.snake)
class Survey {
  final int? id;
  final String? title;
  final List<SurveyQuestion>? questions;
  final bool isCompleted;

  static const empty = Survey(
    id: 0,
    title: '',
    questions: [],
    isCompleted: false,
  );

  const Survey({
    this.id,
    this.title,
    this.questions,
    this.isCompleted = false,
  });

  @override
  String toString() =>
      'Survey(id: $id, title: $title, questions: $questions, isCompleted: $isCompleted)';

  Survey copyWith({
    int? id,
    String? title,
    List<SurveyQuestion>? questions,
    bool? isCompleted,
  }) {
    return Survey(
      id: id ?? this.id,
      title: title ?? this.title,
      questions: questions ?? this.questions,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory Survey.fromJson(String source) => 
      _$SurveyFromJson(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(_$SurveyToJson(this));

  bool get allQuestionsAnswered =>
      questions?.every((question) => question.selectedAnswer != null) ?? false;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Survey &&
        other.id == id &&
        other.title == title &&
        listEquals(other.questions, questions) &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      id,
      title,
      Object.hashAll(questions ?? []),
      isCompleted,
    ]);
  }
}
