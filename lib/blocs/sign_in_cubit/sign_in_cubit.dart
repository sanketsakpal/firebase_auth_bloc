// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:firebase_auth_bloc/model/custom_error.dart';
import 'package:firebase_auth_bloc/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;
  SignInCubit({required this.authRepository}) : super(SignInState.initial());

  Future<void> signIn({required String email, required String password}) async {
    emit(
      state.copyWith(signInStatus: SignInStatus.submitting),
    );
    try {
      await authRepository.singIn(email: email, password: password);
      emit(
        state.copyWith(signInStatus: SignInStatus.success, error: null),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(signInStatus: SignInStatus.error, error: e),
      );
    }
  }
}
