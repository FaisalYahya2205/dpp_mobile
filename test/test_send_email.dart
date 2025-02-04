import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import 'package:http/http.dart' as http;

void main() async {
  await dotenv.load(fileName: ".env");
  final client = OdooClient(dotenv.get("URL"));
  try {
    var response = await http
        .get(Uri.parse("https://dpp.tbdigitalindo.co.id/web/reset_password"));
    debugPrint(
        response.headers["set-cookie"].toString().split("=")[3].split(";")[0]);
    debugPrint(response.body.toString().split("odoo")[2].split('"')[1]);
    debugPrint(response.body.toString().split("value=")[1].split('"')[1]);

    String sessionId =
        response.headers["set-cookie"].toString().split("=")[3].split(";")[0];

    var sendEmail = await http.post(
        Uri.parse("https://dpp.tbdigitalindo.co.id/web/reset_password"),
        headers: {
          "Cookie": "session_id=$sessionId"
        },
        body: {
          "login": "cecep11@gmail.com",
          "csrf_token":
              response.body.toString().split("value=")[1].split('"')[1]
        });
    debugPrint(sendEmail.statusCode.toString());
    debugPrint(sendEmail.headers.toString());
    client.close();
  } on OdooException catch (e) {
    debugPrint(e.message);
    client.close();
  }
  client.close();
}
