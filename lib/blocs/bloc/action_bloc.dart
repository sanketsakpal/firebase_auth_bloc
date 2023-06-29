// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth_bloc/apis/login_api.dart';
import 'package:firebase_auth_bloc/apis/notes_api.dart';
import 'package:firebase_auth_bloc/model/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'action_event.dart';
part 'action_state.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
  final LoginProtocol loginProtocol;
  final NotesApiProtocol notesApiProtocol;
  ActionBloc({
    required this.loginProtocol,
    required this.notesApiProtocol,
  }) : super(const ActionState.empty()) {
    on<LoginAction>(
      (event, emit) async {
        emit(
          const ActionState(
              isLoading: true,
              loginErrors: null,
              loginHandle: null,
              fetchNotes: null),
        );

        final loginHandle = await LoginApi()
            .login(email: event.email, password: event.password);

        emit(
          ActionState(
              isLoading: false,
              loginErrors:
                  loginHandle == null ? LoginErrors.invalidHandle : null,
              loginHandle: loginHandle,
              fetchNotes: null),
        );
      },
    );

    on<LoadNotesActions>((event, emit) async {
      emit(
        ActionState(
            isLoading: true,
            loginErrors: null,
            loginHandle: state.loginHandle,
            fetchNotes: null),
      );

      final loginHandel = state.loginHandle;
      if (loginHandel != const LoginHandle.fooBar()) {
        emit(
          ActionState(
            isLoading: false,
            loginErrors: LoginErrors.invalidHandle,
            loginHandle: loginHandel,
            fetchNotes: null,
          ),
        );
        return;
      } else {
        // this is valid login

        final notes =
            await notesApiProtocol.getNotes(loginHandle: loginHandel!);
        emit(
          ActionState(
              isLoading: false,
              loginErrors: null,
              loginHandle: loginHandel,
              fetchNotes: notes),
        );
      }
    });
  }
}
