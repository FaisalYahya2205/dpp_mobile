// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'survey_post.g.dart';

/// Model class representing a survey post
@JsonSerializable(fieldRename: FieldRename.snake)
class SurveyPost {
  final int surveyId;
  final int partnerId;
  final List<Map<String, dynamic>> userInputLineIds;

  const SurveyPost({
    required this.surveyId,
    required this.partnerId,
    required this.userInputLineIds,
  });

  factory SurveyPost.fromJson(String source) => 
      _$SurveyPostFromJson(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(_$SurveyPostToJson(this));

  @override
  String toString() {
    return 'SurveyPost(surveyId: $surveyId, partnerId: $partnerId, userInputLineIds: $userInputLineIds)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SurveyPost &&
        other.surveyId == surveyId &&
        other.partnerId == partnerId &&
        other.userInputLineIds == userInputLineIds;
  }

  @override
  int get hashCode => Object.hashAll([surveyId, partnerId, userInputLineIds]);
}

class SurveyUserInput {
  int survey_id;
  int partner_id;
  String state;

  SurveyUserInput({
    required this.survey_id,
    required this.partner_id,
    required this.state,
  });

  Map<String, dynamic> toMap() => {
    'survey_id': survey_id,
    'partner_id': partner_id,
    'state': state,
  };

  factory SurveyUserInput.fromMap(Map<String, dynamic> map) => SurveyUserInput(
    survey_id: map['survey_id'] as int,
    partner_id: map['partner_id'] as int,
    state: map['state'] as String,
  );

  String toJson() => json.encode(toMap());

  factory SurveyUserInput.fromJson(String source) => 
      SurveyUserInput.fromMap(json.decode(source) as Map<String, dynamic>);

  SurveyUserInput copyWith({
    int? survey_id,
    int? partner_id,
    String? state,
  }) => SurveyUserInput(
    survey_id: survey_id ?? this.survey_id,
    partner_id: partner_id ?? this.partner_id,
    state: state ?? this.state,
  );
}

class SurveyUserInputLine {
  int user_input_id;
  int survey_id;
  int question_id;
  int question_sequence;
  String answer_type;
  int? suggested_answer_id;
  String? value_text_box;
  double answer_score;
  int matrix_row_id;

  SurveyUserInputLine({
    required this.user_input_id,
    required this.survey_id,
    required this.question_id,
    required this.question_sequence,
    required this.answer_type,
    this.suggested_answer_id,
    this.value_text_box,
    required this.answer_score,
    required this.matrix_row_id,
  });

  Map<String, dynamic> toMap() => {
    'user_input_id': user_input_id,
    'survey_id': survey_id,
    'question_id': question_id,
    'question_sequence': question_sequence,
    'answer_type': answer_type,
    'suggested_answer_id': suggested_answer_id,
    'value_text_box': value_text_box,
    'answer_score': answer_score,
    'matrix_row_id': matrix_row_id,
  };

  factory SurveyUserInputLine.fromMap(Map<String, dynamic> map) => SurveyUserInputLine(
    user_input_id: map['user_input_id'] as int,
    survey_id: map['survey_id'] as int,
    question_id: map['question_id'] as int,
    question_sequence: map['question_sequence'] as int,
    answer_type: map['answer_type'] as String,
    suggested_answer_id: map['suggested_answer_id'] as int?,
    value_text_box: map['value_text_box'] as String?,
    answer_score: map['answer_score'] as double,
    matrix_row_id: map['matrix_row_id'] as int,
  );

  String toJson() => json.encode(toMap());

  factory SurveyUserInputLine.fromJson(String source) => 
      SurveyUserInputLine.fromMap(json.decode(source) as Map<String, dynamic>);

  SurveyUserInputLine copyWith({
    int? user_input_id,
    int? survey_id,
    int? question_id,
    int? question_sequence,
    String? answer_type,
    int? suggested_answer_id,
    String? value_text_box,
    double? answer_score,
    int? matrix_row_id,
  }) => SurveyUserInputLine(
    user_input_id: user_input_id ?? this.user_input_id,
    survey_id: survey_id ?? this.survey_id,
    question_id: question_id ?? this.question_id,
    question_sequence: question_sequence ?? this.question_sequence,
    answer_type: answer_type ?? this.answer_type,
    suggested_answer_id: suggested_answer_id ?? this.suggested_answer_id,
    value_text_box: value_text_box ?? this.value_text_box,
    answer_score: answer_score ?? this.answer_score,
    matrix_row_id: matrix_row_id ?? this.matrix_row_id,
  );
} 