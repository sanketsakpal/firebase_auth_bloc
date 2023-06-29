// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'validation_bloc.dart';

abstract class ValidationEvent extends Equatable {
  const ValidationEvent();

  @override
  List<Object> get props => [];
}

class FormValidatedEvent extends ValidationEvent {}

class ObscureEvent extends ValidationEvent {}

class ValidationChange extends ValidationEvent {
  final String name;
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;
  const ValidationChange({
    required this.name,
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
