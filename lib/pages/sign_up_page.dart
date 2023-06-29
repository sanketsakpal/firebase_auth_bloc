import 'package:firebase_auth_bloc/blocs/sign_up_cubit/sign_up_cubit.dart';
import 'package:firebase_auth_bloc/blocs/sign_up_cubit/sign_up_state.dart';
import 'package:firebase_auth_bloc/pages/sign_in_page.dart';
import 'package:firebase_auth_bloc/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/SignUpPage';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController passwordController = TextEditingController();
  String? name, email, password;

  void submit() {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });
    final from = _fromKey.currentState;
    if (from == null || !from.validate()) {
      return;
    }
    from.save();
    debugPrint("email : $email password: $password");
    context
        .read<SignUpCubit>()
        .signUp(name: name!, email: email!, password: password!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.signUpStatus == SignUpStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _fromKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Image.asset(
                        'assets/images/flutter_logo.png',
                        width: 250,
                        height: 250,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          labelText: "Name",
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Name required';
                          }
                          if (value.length < 2) {
                            return 'Name must be at least more than 2 char';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          name = newValue;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'email required';
                          }
                          if (!isEmail(value.trim())) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          email = newValue;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password required';
                          }
                          if (value.length < 6) {
                            return 'password must be at least 6 characters long';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          password = newValue;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          labelText: "Confirm Password",
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (String? value) {
                          if (passwordController.text != value) {
                            return 'Password not match';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          password = newValue;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: state.signUpStatus == SignUpStatus.submitting
                            ? null
                            : submit,
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        child: Text(
                            state.signUpStatus == SignUpStatus.submitting
                                ? "loading..."
                                : 'Sign Up'),
                      ),
                      const SizedBox(height: 10.0),
                      TextButton(
                        onPressed: state.signUpStatus == SignUpStatus.submitting
                            ? null
                            : () {
                                Navigator.pushNamed(
                                    context, SignInPage.routeName);
                              },
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                              fontSize: 20.0,
                              decoration: TextDecoration.underline),
                        ),
                        child: const Text(
                          "not a member ? Sign In!",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
