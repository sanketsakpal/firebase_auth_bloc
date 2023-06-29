// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'validation_bloc.dart';

enum ValidationStatus { initial, submitting, success, failure }

class ValidationState extends Equatable {
  final ValidationStatus validationStatus;
  final String name;
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;
  final String error;
  final AutovalidateMode autovalidateMode;
  final bool obscurePassword;
  final bool enableSignInButton;
  const ValidationState({
    required this.validationStatus,
    required this.name,
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.error,
    required this.autovalidateMode,
    required this.obscurePassword,
    required this.enableSignInButton,
  });
  factory ValidationState.initial() {
    return const ValidationState(
      validationStatus: ValidationStatus.initial,
      name: '',
      userName: '',
      email: '',
      password: '',
      confirmPassword: '',
      error: '',
      autovalidateMode: AutovalidateMode.disabled,
      obscurePassword: false,
      enableSignInButton: false,
    );
  }

  ValidationState copyWith({
    ValidationStatus? validationStatus,
    String? name,
    String? userName,
    String? email,
    String? password,
    String? confirmPassword,
    String? error,
    AutovalidateMode? autovalidateMode,
    bool? obscurePassword,
    bool? enableSignInButton,
  }) {
    return ValidationState(
      validationStatus: validationStatus ?? this.validationStatus,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      error: error ?? this.error,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      enableSignInButton: enableSignInButton ?? this.enableSignInButton,
    );
  }

  @override
  List<Object> get props {
    return [
      validationStatus,
      name,
      userName,
      email,
      password,
      confirmPassword,
      error,
      autovalidateMode,
      obscurePassword,
      enableSignInButton,
    ];
  }
}
