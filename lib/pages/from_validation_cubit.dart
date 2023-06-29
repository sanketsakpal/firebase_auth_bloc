import 'package:firebase_auth_bloc/blocs/validation_cubit/validation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class FormValidationCubitScreen extends StatelessWidget {
  static const String routeName = '/FormValidationCubitScreen';

  FormValidationCubitScreen({super.key});
  // final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => ValidationCubit(),
        child: BlocConsumer<ValidationCubit, ValidationState>(
          listener: (context, state) {
            if (state.signInStatus == SignInStatus.success) {
              final scaffold = ScaffoldMessenger.of(context);
              scaffold.showSnackBar(const SnackBar(content: Text('success')));
            } else if (state.signInStatus == SignInStatus.failure) {
              final scaffold = ScaffoldMessenger.of(context);
              scaffold.showSnackBar(const SnackBar(content: Text('failure')));
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("cubit validation"),
              ),
              body: Center(
                child: Form(
                  key: cubitFromKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      shrinkWrap: true,
                      reverse: true,
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: "name",
                            prefixIcon: Icon(Icons.account_circle),
                          ),
                          onChanged: ((value) {
                            context.read<ValidationCubit>().validateFrom();
                          }),
                          validator: (String? value) {
                            if (nameController.text.isEmpty) {
                              return 'please enter name';
                            }
                            if (nameController.text.length < 4) {
                              return 'name length must be more than 4 chars';
                            }
                            return null;
                          },
                          onSaved: (newValue) {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: "user name",
                            prefixIcon: Icon(Icons.verified_user_outlined),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter name';
                            }
                            if (value.length < 3) {
                              return ' user name length must be more than 3 chars';
                            }
                            return null;
                          },
                          onSaved: (newValue) {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: "email",
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Email required';
                            }
                            if (!isEmail(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          onSaved: (email) {
                            context.read<ValidationCubit>().emailSaved(email!);
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: "password",
                            prefixIcon: Icon(Icons.remove_red_eye_outlined),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'password required';
                            }
                            if (value.length < 6) {
                              return 'password length is must be more than 6';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            context
                                .read<ValidationCubit>()
                                .passwordSaved(newValue!);
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          obscureText: state.obscurePassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            filled: true,
                            labelText: "confirm password",
                            prefixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<ValidationCubit>()
                                      .obscurePassword();
                                },
                                icon: state.obscurePassword
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                          ),
                          validator: (String? value) {
                            if (passwordController.text != value) {
                              return 'Confirm password not match with password';
                            }
                            return null;
                          },
                          onSaved: (newValue) {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                              onPressed: () {
                                context.read<ValidationCubit>().validateFrom();
                              },
                              child: const Text("submit"),
                            )),
                          ],
                        ),
                      ].reversed.toList(),
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
