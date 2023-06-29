
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'validation_event.dart';
part 'validation_state.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  ValidationBloc() : super(ValidationState.initial()) {
    on<FormValidatedEvent>(_formValidatedEvent);
    on<ObscureEvent>(_obscureEvent);
    on<ValidationChange>(_validationChange);
  }

  void _validationChange(
      ValidationChange event, Emitter<ValidationState> emit) {
    if (event.email.isNotEmpty &&
        event.name.isNotEmpty &&
        event.userName.isNotEmpty &&
        event.password.isNotEmpty &&
        event.confirmPassword.isNotEmpty) {
      emit(state.copyWith(enableSignInButton: true));
    } else {
      emit(state.copyWith(enableSignInButton: false));
    }
  }

  Future<void> _formValidatedEvent(
      FormValidatedEvent event, Emitter<ValidationState> emit) async {
    // print(state);

    try {
      emit(state.copyWith(validationStatus: ValidationStatus.submitting));
      await Future.delayed(const Duration(seconds: 2));
      emit(
        state.copyWith(validationStatus: ValidationStatus.success),
      );
      // print(state);
    } catch (e) {
      emit(
        state.copyWith(
          error: e.toString(),
        ),
      );
    }
  }

  void _obscureEvent(ObscureEvent event, Emitter<ValidationState> emit) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }
}
