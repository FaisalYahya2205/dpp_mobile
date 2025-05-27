import 'package:dpp_mobile/models/survey.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final client = OdooClient(dotenv.get("URL"));
  try {
    await client.authenticate(dotenv.get("DATABASE"), "cecep@gmail.com", "a");
    List<dynamic> userData = await client.callKw({
      'model': 'res.users',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ["email", "=", "cecep@gmail.com"]
        ],
        'fields': ['id', 'partner_id'],
        'limit': 80,
      },
    });
    // debugPrint("USER DATA => ${userData.toString()}");
    List<dynamic> configParam = await client.callKw({
      'model': 'ir.config_parameter',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ['key', '=', 'survey_1_id']
        ],
        'fields': ['id', 'key', 'value'],
      },
    });
    // debugPrint("IR CONFIG => ${configParam.toString()}");
    List<dynamic> surveyData = await client.callKw({
      'model': 'survey.survey',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ['id', '=', configParam[0]['value']]
        ],
        'fields': ['id', 'title'],
      },
    });
    // debugPrint("SURVEY DATA => ${surveyData.toString()}");
    List<dynamic> surveyQuestion = await client.callKw({
      'model': 'survey.question',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ['survey_id', '=', surveyData[0]['id']]
        ],
        'fields': getSurveyQuestionFields(),
        'order': 'sequence asc',
      },
    });

    for (var i = 0; i < surveyQuestion.length; i++) {
      List<dynamic> surveyAnswer = await client.callKw({
        'model': 'survey.question.answer',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [
            ['question_id', '=', surveyQuestion[i]["id"]]
          ],
          'fields': getSurveyAnswerFields(),
          'order': 'sequence asc',
        },
      });
      surveyQuestion[i]["answers"] = surveyAnswer;
    }
    // debugPrint("RAW SURVEY QUESTION => ${surveyQuestion.toString()}");

    final surveyPostHeader = await client.callKw({
      'model': 'survey.user_input',
      'method': 'create',
      'args': [
        {
          'survey_id': surveyData[0]["id"],
          'partner_id': userData[0]["partner_id"][0],
          'state': 'done',
        },
      ],
      'kwargs': {},
    });
    debugPrint("POST HEADER => $surveyPostHeader");

    final surveyPostLines = await client.callKw({
      'model': 'survey.user_input.line',
      'method': 'create',
      'args': [
        {
          "user_input_id": surveyPostHeader,
          "survey_id": 4,
          "question_id": 3,
          "question_sequence": 1,
          "answer_type": "suggestion",
          "suggested_answer_id": 7,
          "value_text_box": "4-5 jam",
          "answer_score": 2.0
        },
      ],
      'kwargs': {},
    });
    debugPrint("POST HEADER => $surveyPostLines");

    client.close();
  } on OdooException catch (e) {
    debugPrint(e.message);
    client.close();
  }
  client.close();
}
