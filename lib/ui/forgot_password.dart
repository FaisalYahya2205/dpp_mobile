// ignore_for_file: use_build_context_synchronously

import 'package:dpp_mobile/utils/themes/app_colors.dart';
import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/widgets/dialogs/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();

  Future<int> sendEmail(email) async {
    try {
      var response = await http
          .get(Uri.parse("https://dpp.tbdigitalindo.co.id/web/reset_password"));
      debugPrint(response.headers["set-cookie"]
          .toString()
          .split("=")[3]
          .split(";")[0]);
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
            "login": email,
            "csrf_token":
                response.body.toString().split("value=")[1].split('"')[1]
          });

      debugPrint(sendEmail.statusCode.toString());
      debugPrint(sendEmail.headers.toString());

      return sendEmail.statusCode;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top + 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Image.asset(
                  "assets/logos/logo.png",
                  height: 96,
                  width: 96,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lupa Password",
                      style: createBlackTextStyle(32),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Halo, masukan email untuk mendapatkan link untuk mereset password Anda",
                      style: createGreyTextStyle(14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextFormField(
                  controller: emailTextController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    hintText: "example@email.com",
                    contentPadding: const EdgeInsets.all(16.0),
                    label: const Text("Email"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'email tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext dialogContext) => AppDialog(
                          type: "loading",
                          title: "Memproses",
                          message: "Mohon tunggu...",
                          onOkPress: () {},
                        ),
                      );

                      debugPrint(emailTextController.text);

                      int sendResult =
                          await sendEmail(emailTextController.text);

                      debugPrint(sendResult.toString());

                      if (sendResult == 0) {
                        Navigator.of(context).pop();
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext dialogContext) => AppDialog(
                            type: "error",
                            title: "Terjadi Kesalahan!",
                            message: "Terjadi kesalahan pada server...",
                            onOkPress: () => Navigator.of(context).pop(),
                          ),
                        );
                      } else {
                        if (sendResult == 200) {
                          Navigator.of(context).pop();
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext dialogContext) => AppDialog(
                              type: "success",
                              title: "Berhasil!",
                              message:
                                  "Email telah dikirim dengan mandat untuk menyetel ulang sandi... \n\n kembali ke login...",
                              onOkPress: () {},
                            ),
                          );

                          Future.delayed(const Duration(seconds: 3), () {
                            context.pop();
                            context.pop();
                          });
                        } else if (sendResult == 400) {
                          Navigator.of(context).pop();
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext dialogContext) => AppDialog(
                              type: "error",
                              title: "Gagal!",
                              message: "Harap cek kembali email Anda...",
                              onOkPress: () => Navigator.of(context).pop(),
                            ),
                          );
                        } else if (sendResult == 404) {
                          Navigator.of(context).pop();
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext dialogContext) => AppDialog(
                              type: "error",
                              title: "Gagal!",
                              message: "Email tidak terdaftar...",
                              onOkPress: () => Navigator.of(context).pop(),
                            ),
                          );
                        } else {
                          Navigator.of(context).pop();
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext dialogContext) => AppDialog(
                              type: "error",
                              title: "Gagal!",
                              message: "Terjadi kesalahan pada server...",
                              onOkPress: () => Navigator.of(context).pop(),
                            ),
                          );
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors().primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    "Kirim",
                    style: createWhiteBoldTextStyle(14),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
