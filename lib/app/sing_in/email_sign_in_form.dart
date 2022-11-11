import 'package:counter_app/app/sing_in/validators.dart';
import 'package:counter_app/common_widgets/show_alert_dialogs.dart';
import 'package:counter_app/common_widgets/show_exeptions_alert_dialog.dart';
import 'package:counter_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  @override
  State<EmailSignInForm> createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  late String email;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _emailEditingConmplite() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;

    FocusScope.of(context).requestFocus(newFocus);
  }

  String get _email => _emailController.text;
  String get _password => _passController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  bool _submited = false;
  bool _isLoading = false;

  void _submit() async {
    setState(() {
      _submited = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExeptionAlertDialog(context,
          title: 'Sing in failed',
          exception: e,
          );
      setState(() {});
    } finally {
      _isLoading = false;
    }
  }

  void _toggleFromType() {
    setState(() {
      _submited = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText =
        _formType == EmailSignInFormType.signIn ? 'Sing in' : 'Create accaunt';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need na account? Register'
        : 'Have an account? Sing In';

    bool submiiEnable = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return [
      _buildEmailTextField(),
      const SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(),
      const SizedBox(
        height: 16.0,
      ),
      ElevatedButton(
        onPressed: submiiEnable ? _submit : null,
        child: Text(primaryText),
      ),
      const SizedBox(
        height: 8.0,
      ),
      TextButton(
        onPressed: !_isLoading ? _toggleFromType : null,
        child: Text(
          secondaryText,
          style: const TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    bool showErorText = _submited && !widget.emailValidator.isValid(_password);

    return TextField(
      onChanged: (password) => _updateState(),
      onEditingComplete: _submit,
      focusNode: _passwordFocusNode,
      controller: _passController,
      obscureText: true,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        label: const Text('Password'),
        errorText: showErorText ? 'Password can\'t be empty' : null,
        enabled: _isLoading == false,
      ),
    );
  }

  TextField _buildEmailTextField() {
    bool showErorText = _submited && widget.emailValidator.isValid(_email);

    return TextField(
      onChanged: (email) => _updateState(),
      onEditingComplete: _emailEditingConmplite,
      focusNode: _emailFocusNode,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      controller: _emailController,
      decoration: InputDecoration(
        label: const Text('Email'),
        hintText: 'test@test.com',
        errorText: showErorText ? 'Email can\'t be empty' : null,
        enabled: _isLoading == false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  _updateState() {
    setState(() {});
  }
}
