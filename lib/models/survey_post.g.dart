// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyPost _$SurveyPostFromJson(Map<String, dynamic> json) => SurveyPost(
      surveyId: json['survey_id'] == false ? 0 : json['survey_id'] as int,
      partnerId:
          json['partner_id'] == false ? 0 : (json['partner_id'] as num).toInt(),
      userInputLineIds: json['user_input_line_ids'] == false
          ? []
          : (json['user_input_line_ids'] as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList(),
    );

Map<String, dynamic> _$SurveyPostToJson(SurveyPost instance) =>
    <String, dynamic>{
      'survey_id': instance.surveyId,
      'partner_id': instance.partnerId,
      'user_input_line_ids': instance.userInputLineIds,
    };
