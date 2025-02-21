import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/models/host_address.dart';
import 'package:dpp_mobile/models/result_error.dart';
import 'package:dpp_mobile/models/session.dart';
import 'package:dpp_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:translator/translator.dart';

class AuthenticationService {
  final translator = GoogleTranslator();

  Future<Map<String, dynamic>> authentication(
    String username,
    String password,
    String hostUrl,
    String databaseName,
  ) async {
    try {
      debugPrint("AUTH => init Client $hostUrl");
      client = OdooClient(hostUrl);
      debugPrint("AUTH => ${client.toString()}");

      debugPrint("AUTH => init Session");
      OdooSession odooSession =
          await client!.authenticate(databaseName, username, password);
      debugPrint("AUTH => $odooSession");

      if (odooSession.runtimeType != OdooSession) {
        debugPrint("Session INVALID");
        return {
          "success": false,
          "errorMessage": "Authentication Error",
          "data": {},
        };
      }

      debugPrint("AUTH => init User");
      final userData = await client!.callKw({
        "model": "res.users",
        "method": "search_read",
        "args": [],
        "kwargs": {
          "context": {"bin_size": true},
          "domain": [
            ["email", "=", username]
          ],
          "fields": getUserFields(),
        },
      });

      await databaseHelper!.insertQuery(
        "session",
        Session(
          user_id: odooSession.userId,
          partner_id: userData[0]["partner_id"][0],
          session_id: odooSession.id,
          user_login: odooSession.userLogin,
          user_name: odooSession.userName,
          password: password,
          login_state: 1,
        ).toMap(),
      );

      await databaseHelper!.insertQuery(
        "host_address",
        HostAddress(
          user_id: odooSession.userId,
          host_url: hostUrl,
          database_name: databaseName,
        ).toMap(),
      );

      debugPrint("AUTH => All Set");

      return {
        "success": true,
        "errorMessage": "",
        "data": {},
      };
    } on OdooException catch (e) {
      debugPrint(e.toString());
      String message = e.message.split("message: ")[2].split(",")[0];
      Translation errorMessage =
          await translator.translate(message, from: "en", to: "id");
      return {
        "success": false,
        "errorMessage": errorMessage.text,
        "data": {},
      };
    } on ClientException {
      return {
        "success": false,
        "errorMessage": "Terjadi masalah dengan server...",
        "data": {},
      };
    } catch (e) {
      debugPrint(e.toString());
      throw ErrorEmptyResponse();
    }
  }
}
