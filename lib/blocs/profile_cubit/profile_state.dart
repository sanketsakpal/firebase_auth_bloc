// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:firebase_auth_bloc/model/custom_error.dart';
import 'package:firebase_auth_bloc/model/user_model.dart';

enum ProfileStatus { initial, loading, loaded, error }

// ignore: must_be_immutable
class ProfileState extends Equatable {
  ProfileStatus profileStatus;
  final User user;
  final CustomError error;
  ProfileState({
    required this.profileStatus,
    required this.user,
    required this.error,
  });
  factory ProfileState.initial() {
    return ProfileState(
      profileStatus: ProfileStatus.initial,
      user: User.initial(),
      error: const CustomError(),
    );
  }
  @override
  bool get stringify => true;

  @override
  List<Object> get props => [profileStatus, user, error];

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    User? user,
    CustomError? error,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
