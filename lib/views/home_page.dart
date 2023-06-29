import 'package:firebase_auth_bloc/apis/login_api.dart';
import 'package:firebase_auth_bloc/blocs/bloc/action_bloc.dart';
import 'package:firebase_auth_bloc/generic_dialog/generic_dialog.dart';
import 'package:firebase_auth_bloc/generic_dialog/loading_screen.dart';
import 'package:firebase_auth_bloc/model/login_model.dart';
import 'package:firebase_auth_bloc/utils/string.dart';
import 'package:firebase_auth_bloc/views/iterable_list_view.dart';
import 'package:firebase_auth_bloc/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewHomePage extends StatelessWidget {
  static const String routeName = '/ViewHomePage';
  const ViewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActionBloc(
        loginProtocol: LoginApi(),
        notesApiProtocol: NoteApi(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("HomePage"),
        ),
        body: BlocConsumer<ActionBloc, ActionState>(
          listener: (context, state) {
            // take care of loading screen

            if (state.isLoading) {
              LoadingScreen.instance().show(context: context, text: pleaseWait);
            } else {
              LoadingScreen.instance().hide();
            }

            // display possible error
            final loginError = state.loginErrors;
            if (loginError != null) {
              showGenericDialog(
                context: context,
                title: loginErrorDialogTitle,
                content: loginErrorDialogContent,
                optionBuilder: () => {ok: true},
              );
            }

            // if we are logged in , but we have no fetched notes ,fetch them now.
            if (state.isLoading == false &&
                state.loginErrors == null &&
                state.loginHandle == const LoginHandle.fooBar() &&
                state.fetchNotes == null) {
              context.read<ActionBloc>().add(LoadNotesActions());
            }
          },
          builder: (context, state) {
            final notes = state.fetchNotes;
            if (notes == null) {
              return LoginView(
                onLoginTapped: (email, password) {
                  context
                      .read<ActionBloc>()
                      .add(LoginAction(email: email, password: password));
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
