// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStateChangedEvent extends AuthEvent {
  final fb_auth.User? user;
  const AuthStateChangedEvent({
    this.user,
  });
    @override
      List<Object?> get props => [user];
}
class SignOutRequestedEvent extends AuthEvent{
  
}