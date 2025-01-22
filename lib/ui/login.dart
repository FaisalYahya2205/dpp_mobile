// ignore_for_file: use_build_context_synchronously

import 'package:dpp_mobile/database/database.dart';
import 'package:dpp_mobile/main.dart';
import 'package:dpp_mobile/services/odoo_service.dart';
import 'package:dpp_mobile/widgets/dialogs/app_dialog.dart';
import 'package:flutter/material.dart';
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
  bool hidePassword = true;

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
                      icon:
                          Icon(hidePassword ? Iconsax.eye_slash : Iconsax.eye),
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
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GestureDetector(
                  onTap: () {},
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
                        Future.delayed(const Duration(seconds: 2), () async {
                          localSession = await DatabaseHelper.instance
                              .getAllQuery("session");
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
              // const SizedBox(
              //   height: 56,
              // ),
              // Container(
              //   alignment: Alignment.center,
              //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         "Belum punya akun? ",
              //         style: createBlackTextStyle(14),
              //       ),
              //       GestureDetector(
              //         onTap: () {},
              //         child: Text(
              //           "Daftar",
              //           style: createPrimaryTextStyle(14),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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
