// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth_bloc/views/email_text_field.dart';
import 'package:firebase_auth_bloc/views/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:firebase_auth_bloc/views/login_button.dart';

class LoginView extends HookWidget {
  final OnLoginTapped onLoginTapped;
  const LoginView({
    super.key,
    required this.onLoginTapped,
  });

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          EmailTextField(emailController: emailController),
          PasswordTextField(
            passwordController: passwordController,
          ),
          LoginButton(
              emailController: emailController,
              passwordController: passwordController,
              loginTapped: onLoginTapped)
        ],
      ),
    );
  }
}
