import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final client = OdooClient(dotenv.get("URL"));
  try {
    await client.authenticate(
        dotenv.get("DATABASE"), "andiade52@gmail.com", "a");
    final config_param = await client.callKw({
      'model': 'ir.config_parameter',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ['key', '=', 'survey_1_id']
        ],
        'fields': ['key', 'value'],
      },
    });
    debugPrint(config_param[0].toString());
    final surveyData = await client.callKw({
      'model': 'survey.survey',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ['id', '=', config_param[0]['value']]
        ],
        'fields': ['id', 'title'],
      },
    });
    debugPrint(surveyData[0].toString());
    final surveyQuestion = await client.callKw({
      'model': 'survey.question',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ['survey_id', '=', surveyData[0]['id']]
        ],
        'fields': ['id', 'sequence', 'title'],
      },
    });
    debugPrint(surveyQuestion.toString());
    final surveyAnswer = await client.callKw({
      'model': 'survey.question.answer',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ['question_id', 'in', [3, 4]]
        ],
        'fields': ['id', 'sequence', 'question_id', 'value', 'answer_score'],
      },
    });
    debugPrint(surveyAnswer.toString());
    client.close();
  } on OdooException catch (e) {
    debugPrint(e.message);
    client.close();
  }
  client.close();
}
