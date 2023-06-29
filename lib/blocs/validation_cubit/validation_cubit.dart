

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'validation_state.dart';

class ValidationCubit extends Cubit<ValidationState> {
  ValidationCubit() : super(ValidationState.initial());

  void emailSaved(String email) {
    emit(state.copyWith(email: email));
    debugPrint("state: $state");
  }

  void passwordSaved(String password) {
    emit(state.copyWith(password: password));
    debugPrint("state: $state");
  }

  void validateFrom() {
    if (cubitFromKey.currentState!.validate()) {
      emit(state.copyWith(
          signInStatus: SignInStatus.success,
          autovalidateMode: AutovalidateMode.always));
      debugPrint("state: $state");
    } else {
      emit(
        state.copyWith(signInStatus: SignInStatus.failure),
      );
    }
  }

  void obscurePassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }
}
