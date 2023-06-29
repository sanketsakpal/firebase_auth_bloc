import 'package:firebase_auth_bloc/model/login_model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();

  Future<Iterable<Notes>?> getNotes({required LoginHandle loginHandle});
}
