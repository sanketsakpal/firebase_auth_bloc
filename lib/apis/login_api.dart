import 'package:firebase_auth_bloc/apis/notes_api.dart';
import 'package:firebase_auth_bloc/model/login_model.dart';
import 'package:flutter/material.dart';

abstract class LoginProtocol {
  const LoginProtocol();

  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

@immutable
class LoginApi implements LoginProtocol {
  // const LoginApi._sharedInstance();
  // static const LoginApi _shared = LoginApi._sharedInstance();
  // factory LoginApi.instance() => _shared;

  @override
  Future<LoginHandle?> login(
          {required String email, required String password}) =>
      Future.delayed(const Duration(seconds: 2),
              () => email == 'foo@bar.com' && password == 'foobar')
          .then((isLoggedIn) => isLoggedIn ? const LoginHandle.fooBar() : null);
}

class NoteApi implements NotesApiProtocol {
  @override
  Future<Iterable<Notes>?> getNotes({required LoginHandle loginHandle}) =>
      Future.delayed(const Duration(seconds: 2),
          () => loginHandle == const LoginHandle.fooBar() ? mockNotes : null);
}
