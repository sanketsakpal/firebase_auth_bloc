// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'action_bloc.dart';

abstract class ActionEvent {
  const ActionEvent();
}

@immutable
class LoginAction implements ActionEvent {
  final String email;
  final String password;
  const LoginAction({
    required this.email,
    required this.password,
  });

  @override
  String toString() => 'LoginAction(email: $email, password: $password)';
}

@immutable
class LoadNotesActions implements ActionEvent {}
