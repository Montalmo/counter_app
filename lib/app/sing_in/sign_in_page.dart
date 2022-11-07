import 'package:counter_app/app/sing_in/email_sign_in_page.dart';
import 'package:counter_app/app/sing_in/sign_in_button.dart';
import 'package:counter_app/app/sing_in/social_sign_in_button.dart';
import 'package:counter_app/services/auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  Future<void> _signInAnonymously(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    await auth.signInAnonymously();
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    await auth.signInWithGoogle();
  }

  Future<void> _signWithInFacebook(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    await auth.signWithInFacebook();
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time tracker'),
        elevation: 2.0,
        centerTitle: true,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Sign in with Google',
            color: Colors.white,
            textColor: Colors.black87,
            onPress: () => _signInWithGoogle(context),
          ),
          const SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign in with Facebook',
            color: const Color(0xFF334D92),
            textColor: Colors.white,
            onPress: () => _signWithInFacebook,
          ),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
              text: 'Sign in with Email',
              color: const Color.fromARGB(255, 3, 112, 101),
              textColor: Colors.white,
              onPress: () => _signInWithEmail(context)),
          const SizedBox(
            height: 8.0,
          ),
          const Text(
            'or',
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Go anonymous',
            color: Colors.lime,
            textColor: Colors.black87,
            onPress: () => _signInAnonymously,
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
