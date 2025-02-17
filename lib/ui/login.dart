// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dpp_mobile/database/database.dart';
import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/services/odoo_service.dart';
import 'package:dpp_mobile/widgets/dialogs/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iconsax/iconsax.dart';

import 'package:dpp_mobile/utils/themes/text_style.dart';
import 'package:dpp_mobile/utils/themes/app_colors.dart';

import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController urlTextController = TextEditingController();
  TextEditingController databaseTextController = TextEditingController();
  bool hidePassword = true;
  bool showUrlDatabase = false;

  DateTime? currentPress;

  @override
  void initState() {
    urlTextController.text = dotenv.get("URL");
    databaseTextController.text = dotenv.get("DATABASE");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (state, value) {
          debugPrint(state.toString());
          debugPrint(value.toString());
          if (showUrlDatabase) {
            setState(() {
              showUrlDatabase = !showUrlDatabase;
            });
            return;
          }
          final now = DateTime.now();
          if (currentPress == null ||
              now.difference(currentPress!) > const Duration(seconds: 2)) {
            currentPress = now;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tekan sekali lagi untuk keluar'),
                duration: Duration(seconds: 1),
              ),
            );
            return;
          } else {
            debugPrint("EXIT");
            exit(0);
          }
        },
        child: SingleChildScrollView(
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
                        "Selamat Datang 👋",
                        style: createBlackTextStyle(32),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'di ',
                          style: createBlackTextStyle(32),
                          children: [
                            TextSpan(
                              text: 'HR Attendee',
                              style: createPrimaryTextStyle(32),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Halo, masuk untuk melanjutkan",
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
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextFormField(
                    controller: passwordTextController,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      hintText: "",
                      contentPadding: const EdgeInsets.all(16.0),
                      label: const Text("Password"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() => hidePassword = !hidePassword);
                        },
                        icon: Icon(
                            hidePassword ? Iconsax.eye_slash : Iconsax.eye),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                showUrlDatabase
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TextFormField(
                          controller: urlTextController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            hintText: "https://example.com/",
                            contentPadding: const EdgeInsets.all(16.0),
                            label: const Text("Host"),
                          ),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: showUrlDatabase ? 16 : 0,
                ),
                showUrlDatabase
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TextFormField(
                          controller: databaseTextController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            hintText: "Database Name",
                            contentPadding: const EdgeInsets.all(16.0),
                            label: const Text("Database"),
                          ),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: showUrlDatabase ? 16 : 0,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: GestureDetector(
                    onTap: () => context.push("/forget_password"),
                    child: Text(
                      "Lupa Password",
                      textAlign: TextAlign.end,
                      style: createPrimaryTextStyle(14),
                    ),
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
                        if ((urlTextController.text.isNotEmpty &&
                                databaseTextController.text.isEmpty) ||
                            (urlTextController.text.isEmpty &&
                                databaseTextController.text.isNotEmpty)) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext dialogContext) => AppDialog(
                              type: "error",
                              title: "Konsistensi Host!",
                              message:
                                  "Host dan Database harus diisi keduanya atau kosongkan keduanya",
                              onOkPress: () => Navigator.of(context).pop(),
                            ),
                          );
                          return;
                        }

                        Map<String, dynamic> result = await checkDifferentHost(
                          context,
                          emailTextController.text,
                          urlTextController.text,
                          databaseTextController.text,
                          showUrlDatabase,
                        );

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

                        bool auth = await OdooService().authentication(
                          emailTextController.text,
                          passwordTextController.text,
                          result["hostUrl"],
                          result["databaseName"],
                        );

                        if (auth) {
                          Navigator.of(context).pop();
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext dialogContext) => AppDialog(
                              type: "success",
                              title: "Login Berhasil!",
                              message: "Mengalihkan...",
                              onOkPress: () {},
                            ),
                          );
                          localSession =
                              await DatabaseHelper.instance.getAllQuery(
                            "session",
                            "login_state = ?",
                            [1],
                          );
                          localHost = await DatabaseHelper.instance.getAllQuery(
                            "host_address",
                            "user_id = ?",
                            [localSession!.first["user_id"]],
                          );
                          Future.delayed(const Duration(seconds: 2), () async {
                            Navigator.of(context).pop();
                            context.go("/dashboard");
                          });
                        } else {
                          Navigator.of(context).pop();
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext dialogContext) => AppDialog(
                              type: "error",
                              title: "Login Gagal!",
                              message: "Cek kembali data anda...",
                              onOkPress: () => Navigator.of(context).pop(),
                            ),
                          );
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
                      "Masuk",
                      style: createWhiteBoldTextStyle(14),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() => showUrlDatabase = !showUrlDatabase);
                        },
                        child: Text(
                          showUrlDatabase
                              ? "Sembunyikan Host Khusus"
                              : "Masukan Host Khusus",
                          style: createPrimaryTextStyle(14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> checkDifferentHost(
    BuildContext context,
    String email,
    String hostUrl,
    String databaseName,
    bool showCustomUrl,
  ) async {
    List<Map<String, dynamic>> checkSession = await databaseHelper!
        .getAllQuery("session", "user_login = ?", [emailTextController.text]);

    if (checkSession.isEmpty) {
      return {
        "isDifferent": true,
        "hostUrl": hostUrl,
        "databaseName": databaseName,
      };
    }

    List<Map<String, dynamic>> checkHost = await databaseHelper!.getAllQuery(
        "host_address", "user_id = ?", [checkSession.first["user_id"]]);

    bool hostDifferent = true;
    bool databaseDifferent = true;

    if (showCustomUrl && checkHost.first["host_url"] != hostUrl) {
      hostDifferent = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext dialogContext) => AppDialog(
          type: "confirm",
          title: "Konfirmasi Host",
          message:
              "Email ini telah terdata dengan host yang berbeda, ingin mengganti host?",
          onOkPress: () async {
            context.pop(true);
          },
          okTitle: "Iya",
          cancelTitle: "Tidak",
        ),
      );
    }

    if (showCustomUrl && checkHost.first["database_name"] != databaseName) {
      databaseDifferent = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext dialogContext) => AppDialog(
          type: "confirm",
          title: "Konfirmasi Database",
          message:
              "Email ini telah terdata dengan database yang berbeda, ingin mengganti database?",
          onOkPress: () async {
            context.pop(true);
          },
          okTitle: "Ya",
          cancelTitle: "Tidak",
        ),
      );
    }

    return {
      "isDifferent": true,
      "hostUrl": hostDifferent ? hostUrl : checkHost.first["host_url"],
      "databaseName":
          databaseDifferent ? databaseName : checkHost.first["database_name"],
    };
  }
}
