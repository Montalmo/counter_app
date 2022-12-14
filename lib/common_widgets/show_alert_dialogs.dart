import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool?> showAlertDialog(BuildContext context,
    {required String title,
    required String content,
    required String defaultActionText,
    String cancelActionText = 'Cancel'}) {
  if (!Platform.isIOS) {
    return showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if (cancelActionText != null)
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(cancelActionText)),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(defaultActionText),
          ),
        ],
      ),
    );
  } else {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if (cancelActionText != null)
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(cancelActionText)),
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(defaultActionText),
          ),
        ],
      ),
    );
  }
}
