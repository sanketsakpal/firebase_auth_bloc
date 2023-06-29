import 'dart:math' as math show Random;


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'names_state.dart';

final names = [
  'Foo',
  'Bar',
  'Baz',
];

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickName() => emit(
        names.getRandomElement(),
      );
}

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}
