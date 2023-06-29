// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'validation_cubit.dart';

enum SignInStatus { initial, submitting, success, failure }

final TextEditingController nameController = TextEditingController();
final GlobalKey<FormState> cubitFromKey = GlobalKey<FormState>();

class ValidationState extends Equatable {
  final SignInStatus signInStatus;
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
    required this.signInStatus,
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
      signInStatus: SignInStatus.initial,
      name: '',
      userName: '',
      email: '',
      password: '',
      confirmPassword: '',
      error: '',
      autovalidateMode: AutovalidateMode.disabled,
      enableSignInButton: false,
      obscurePassword: false,
    );
  }

  ValidationState copyWith({
    SignInStatus? signInStatus,
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
      signInStatus: signInStatus ?? this.signInStatus,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      error: error ?? this.error,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      enableSignInButton: enableSignInButton ?? this.enableSignInButton,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  @override
  List<Object> get props {
    return [
      signInStatus,
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

  @override
  String toString() {
    return 'ValidationState(signInStatus: $signInStatus, name: $name, userName: $userName, email: $email, password: $password, confirmPassword: $confirmPassword, error: $error, autovalidateMode: $autovalidateMode)';
  }

  @override
  bool get stringify => true;
}
