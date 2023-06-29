
import 'package:firebase_auth_bloc/blocs/sign_up_cubit/sign_up_state.dart';
import 'package:firebase_auth_bloc/model/custom_error.dart';
import 'package:firebase_auth_bloc/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  SignUpCubit({required this.authRepository}) : super(SignUpState.initial());

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    emit(
      state.copyWith(signUpStatus: SignUpStatus.submitting),
    );
    try {
      await authRepository.signUp(name: name, email: email, password: password);
      emit(
        state.copyWith(signUpStatus: SignUpStatus.success, error: null),
      );
    } on CustomError catch (e) {
      emit(
        state.copyWith(signUpStatus: SignUpStatus.error, error: e),
      );
    }
  }
}
