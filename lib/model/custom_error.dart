import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomError extends Equatable {
  final String code;
  final String message;
  final String plugin;
  const CustomError({
    this.code = '',
    this.message = '',
    this.plugin = '',
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [code, message, plugin];
}
