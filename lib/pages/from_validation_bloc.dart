import 'package:firebase_auth_bloc/blocs/validation_bloc/validation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormValidationBlocScreen extends StatefulWidget {
  static const String routeName = '/FormValidationBlocScreen';
  const FormValidationBlocScreen({super.key});

  @override
  State<FormValidationBlocScreen> createState() =>
      _FormValidationBlocScreenState();
}

TextEditingController passwordController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController userNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();
final GlobalKey<FormState> blocFromKey = GlobalKey<FormState>();

class _FormValidationBlocScreenState extends State<FormValidationBlocScreen> {
  void onSubmit(BuildContext context) {
    final form = blocFromKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();
    context.read<ValidationBloc>().add(FormValidatedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => ValidationBloc(),
        child: BlocConsumer<ValidationBloc, ValidationState>(
          listener: (context, state) {
            if (state.validationStatus == ValidationStatus.success) {
              final scaffold = ScaffoldMessenger.of(context);
              scaffold.showSnackBar(const SnackBar(content: Text('success')));
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("bloc validation"),
              ),
              body: Center(
                child: Form(
                  key: blocFromKey,
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
                          // controller: nameController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: "name",
                            prefixIcon: Icon(Icons.account_circle),
                          ),
                          onChanged: (_) => context.read<ValidationBloc>().add(
                              ValidationChange(
                                  name: nameController.text,
                                  userName: userNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text)),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter name';
                            }
                            return null;
                          },
                          onSaved: (newValue) {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: userNameController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: "user name",
                            prefixIcon: Icon(Icons.verified_user_outlined),
                          ),
                          onChanged: (_) => context.read<ValidationBloc>().add(
                              ValidationChange(
                                  name: nameController.text,
                                  userName: userNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text)),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter user name';
                            }
                            return null;
                          },
                          onSaved: (newValue) {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: "email",
                            prefixIcon: Icon(Icons.email),
                          ),
                          onChanged: (_) => context.read<ValidationBloc>().add(
                              ValidationChange(
                                  name: nameController.text,
                                  userName: userNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text)),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter email ';
                            }
                            return null;
                          },
                          onSaved: (newValue) {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: state.obscurePassword,
                          autocorrect: false,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              filled: true,
                              labelText: "password",
                              prefixIcon: IconButton(
                                onPressed: () {
                                  context.read<ValidationBloc>().add(
                                        ObscureEvent(),
                                      );
                                },
                                icon: state.obscurePassword
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                              )

                              //  Icon(Icons.remove_red_eye_outlined),
                              ),
                          onChanged: (_) => context.read<ValidationBloc>().add(
                              ValidationChange(
                                  name: nameController.text,
                                  userName: userNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text)),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter password';
                            }
                            return null;
                          },
                          onSaved: (newValue) {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          obscureText: state.obscurePassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            filled: true,
                            labelText: "confirm password",
                            prefixIcon: state.obscurePassword
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                          onChanged: (_) => context.read<ValidationBloc>().add(
                              ValidationChange(
                                  name: nameController.text,
                                  userName: userNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text)),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter confirm password';
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
                              onPressed: state.enableSignInButton == false
                                  ? null
                                  : state.validationStatus ==
                                          ValidationStatus.submitting
                                      ? null
                                      : () => onSubmit(context),
                              child: state.validationStatus ==
                                      ValidationStatus.submitting
                                  ? const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : const Text("submit"),
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
