import 'package:counter_app/common_widgets/show_alert_dialogs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> showExeptionAlertDialog(BuildContext context,
        {required String title, required Exception exception}) =>
    showAlertDialog(
      context,
      title: title,
      content: _message(exception) as String,
      defaultActionText: 'OK',
    );

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message as String;
  }
  return exception.toString();
}
