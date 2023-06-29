// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth_bloc/generic_dialog/generic_dialog.dart';
import 'package:firebase_auth_bloc/utils/string.dart';
import 'package:flutter/material.dart';

typedef OnLoginTapped = void Function(
  String email,
  String password,
);

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final OnLoginTapped loginTapped;
  const LoginButton({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.loginTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          final email = emailController.text;
          final password = passwordController.text;
          if (email.isEmpty || password.isEmpty) {
            showGenericDialog(
              context: context,
              title: email0rPasswordEmptyDialogTitle,
              content: email0rPasswordEmptyDescription,
              optionBuilder: () => {ok: true},
            );
          } else {
            loginTapped(email, password);
          }
        },
        child: const Text(login));
  }
}
