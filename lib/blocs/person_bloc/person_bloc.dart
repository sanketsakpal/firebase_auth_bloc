import 'package:firebase_auth_bloc/blocs/person_bloc/person_event.dart';
import 'package:firebase_auth_bloc/blocs/person_bloc/person_state.dart';
import 'package:firebase_auth_bloc/model/person_model.dart';
import 'package:firebase_auth_bloc/pages/youtube_bloc_and_cubit_example.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonUrl, Iterable<Person>> _cache = {};
  PersonsBloc() : super(null) {
    on<LoadPersonAction>(
      (event, emit) async {
        final url = event.url;
        if (_cache.containsKey(url)) {
          final cachePersons = _cache[url];
          final result =
              FetchResult(persons: cachePersons!, isRetrievedFromCache: true);
          emit(result);
        } else {
          final person = await getPerson(url.urlString);
          _cache[url] = person;
          final result =
              FetchResult(persons: person, isRetrievedFromCache: false);
          emit(result);
        }
      },
    );
  }
}

