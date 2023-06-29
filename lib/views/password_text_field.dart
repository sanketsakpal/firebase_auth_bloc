import 'package:firebase_auth_bloc/utils/string.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordTextField({super.key, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      autocorrect: false,
      obscureText: true,
      obscuringCharacter: '℉',
      decoration: const InputDecoration(
        hintText: enterYourPasswordHere,
      ),
    );
  }
}
