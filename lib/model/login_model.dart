// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;

@immutable
class LoginHandle {
  final String token;
  const LoginHandle({
    required this.token,
  });
  const LoginHandle.fooBar() : token = 'fooBar';

  @override
  bool operator ==(covariant LoginHandle other) {
    if (identical(this, other)) return true;

    return other.token == token;
  }

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() => 'LoginHandle(token: $token)';
}

enum LoginErrors { invalidHandle }

@immutable
class Notes {
  final String title;
  const Notes({
    required this.title,
  });

  @override
  String toString() => 'Notes(title: $title)';
}

final mockNotes = Iterable.generate(
  3,
  (i) => Notes(title: 'Notes ${i + 1}'),
);
