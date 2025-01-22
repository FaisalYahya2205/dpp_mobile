import 'package:dpp_mobile/widgets/dialogs/error_dialog.dart';
import 'package:dpp_mobile/widgets/dialogs/loading_dialog.dart';
import 'package:dpp_mobile/widgets/dialogs/success_dialog.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.type,
    required this.title,
    required this.message,
    required this.onOkPress,
  });

  final String type;
  final String title;
  final String message;
  final VoidCallback onOkPress;

  @override
  Widget build(BuildContext context) {
    if (type == "success") {
      return SuccessDialog(title: title, message: message);
    } else if (type == "error") {
      return ErrorDialog(
        title: title,
        message: message,
        onOkPress: onOkPress,
      );
    }

    return LoadingDialog(title: title, message: message);
  }
}
