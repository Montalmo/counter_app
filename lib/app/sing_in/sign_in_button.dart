import 'package:counter_app/common_widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({super.key, 
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPress,
  }) : super(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
          color: color,
          onPress: onPress,
        );
}
