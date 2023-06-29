// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'action_bloc.dart';

class ActionState extends Equatable {
  final bool isLoading;
  final LoginErrors? loginErrors;
  final LoginHandle? loginHandle;
  final Iterable<Notes>? fetchNotes;

  const ActionState.empty()
      : isLoading = false,
        loginErrors = null,
        loginHandle = null,
        fetchNotes = null;
  const ActionState({
    required this.isLoading,
    required this.loginErrors,
    required this.loginHandle,
    required this.fetchNotes,
  });

  @override
  List<Object?> get props => [
        isLoading,
        loginErrors,
        loginHandle,
        fetchNotes,
      ];

  @override
  bool get stringify => true;
}
