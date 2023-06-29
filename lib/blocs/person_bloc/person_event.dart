import 'package:firebase_auth_bloc/blocs/person_bloc/person_state.dart';

class LoadPersonAction extends LoadAction {
  final PersonUrl url;
  const LoadPersonAction({required this.url}) : super();
}
