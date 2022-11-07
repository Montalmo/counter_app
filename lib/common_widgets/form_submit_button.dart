import 'package:counter_app/common_widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    super.key,
    required String text,
    required VoidCallback onPress,
  }) : super(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            height: 50.0,
            color: Colors.indigo,
            borderRadius: 4.0,
            onPress: onPress);
}
