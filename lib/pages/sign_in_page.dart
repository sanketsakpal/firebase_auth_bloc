import 'package:firebase_auth_bloc/blocs/sign_in_cubit/sign_in_cubit.dart';
import 'package:firebase_auth_bloc/pages/sign_up_page.dart';
import 'package:firebase_auth_bloc/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/SignInPage';
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, password;

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
    context.read<SignInCubit>().signIn(email: email!, password: password!);
    // Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state.signInStatus == SignInStatus.error) {
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
                          keyboardType: TextInputType.emailAddress,
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
                        ElevatedButton(
                          onPressed:
                              state.signInStatus == SignInStatus.submitting
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
                              state.signInStatus == SignInStatus.submitting
                                  ? "loading..."
                                  : 'Sign In'),
                        ),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed:
                              state.signInStatus == SignInStatus.submitting
                                  ? null
                                  : () {
                                      Navigator.pushNamed(
                                          context, SignUpPage.routeName);
                                    },
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 20.0,
                                decoration: TextDecoration.underline),
                          ),
                          child: const Text(
                            "not a member ? Sign Up!",
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("FB LOgin"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
