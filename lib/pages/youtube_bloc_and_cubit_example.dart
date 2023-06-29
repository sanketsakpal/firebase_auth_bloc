// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth_bloc/blocs/person_bloc/person_bloc.dart';
import 'package:firebase_auth_bloc/blocs/person_bloc/person_event.dart';
import 'package:firebase_auth_bloc/blocs/person_bloc/person_state.dart';
import 'package:firebase_auth_bloc/model/person_model.dart';
import 'package:firebase_auth_bloc/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth_bloc/blocs/names_cubit/names_cubit.dart';

class YoutubeBlocAndCubitExample extends StatefulWidget {
  static const String routeName = '/YoutubeBlocAndCubitExample';
  const YoutubeBlocAndCubitExample({super.key});

  @override
  State<YoutubeBlocAndCubitExample> createState() =>
      _YoutubeBlocAndCubitExampleState();
}

class _YoutubeBlocAndCubitExampleState
    extends State<YoutubeBlocAndCubitExample> {
  late final NamesCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = NamesCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // StreamBuilder<String?>(
            //   stream: cubit.stream,
            //   builder: (context, snapshot) {
            //     final button = TextButton(
            //       onPressed: () {
            //         cubit.pickName();
            //         // context.read<NamesCubit>().pickName();
            //       },
            //       child: const Text("random name"),
            //     );

            //     switch (snapshot.connectionState) {
            //       case ConnectionState.none:
            //         return button;

            //       case ConnectionState.waiting:
            //         return button;

            //       case ConnectionState.active:
            //         return Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               snapshot.data ?? '',
            //               style: TextStyle(color: Colors.black),
            //             ),
            //             button
            //           ],
            //         );

            //       case ConnectionState.done:
            //         return const Text(
            //           "error",
            //           style: TextStyle(color: Colors.black),
            //         );
            //     }
            //   },
            // ),
            TextButton(
              onPressed: () {
                context.read<PersonsBloc>().add(
                      const LoadPersonAction(url: PersonUrl.person1),
                    );
              },
              child: const Text("load json 1"),
            ),
            TextButton(
              onPressed: () {
                context.read<PersonsBloc>().add(
                      const LoadPersonAction(url: PersonUrl.person2),
                    );
              },
              child: const Text("load json 2"),
            ),
            BlocBuilder<PersonsBloc, FetchResult?>(
              buildWhen: (previous, current) {
                return previous?.persons != current?.persons;
              },
              builder: (context, state) {
                state?.log();
                final persons = state?.persons;
                if (persons == null) {
                  return const SizedBox();
                }
                return

                    // Expanded(
                    //   child:

                    ListView.builder(
                  shrinkWrap: true,
                  itemCount: persons.length,
                  itemBuilder: (context, index) {
                    final person = persons[index];
                    return ListTile(
                      title: Text(person?.name ?? ""),
                    );
                  },
                  // ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// abstract class LoadAction {
//   const LoadAction();
// }

// enum PersonUrl {
//   person1,
//   person2,
// }

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.person1:
        return 'http://127.0.0.1:5500/api/person1.json';

      case PersonUrl.person2:
        return 'http://127.0.0.1:5500/api/person2.json';
    }
  }
}

// class LoadPersonAction extends LoadAction {
//   final PersonUrl url;
//   const LoadPersonAction({required this.url}) : super();
// }

Future<Iterable<Person>> getPerson(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((resp) => resp.transform(const Utf8Decoder()).join())
    .then((str) => jsonDecode(str) as List<dynamic>)
    .then(
      (list) => list.map(
        (e) => Person.fromJson(e),
      ),
    );

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;
  const FetchResult(
      {required this.persons, required this.isRetrievedFromCache});

  @override
  String toString() =>
      'FetchResult(persons: $persons, isRetrievedFromCache: $isRetrievedFromCache)';
}

// @immutable
// class LoadPersonsAction implements LoadAction {
//   final PersonUrl url;
//   const LoadPersonsAction({required this.url}) : super();
// }

// class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
//   final Map<PersonUrl, Iterable<Person>> _cache = {};
//   PersonsBloc() : super(null) {
//     on<LoadPersonAction>(
//       (event, emit) async {
//         final url = event.url;
//         if (_cache.containsKey(url)) {
//           final cachePersons = _cache[url];
//           final result =
//               FetchResult(persons: cachePersons!, isRetrievedFromCache: true);
//           emit(result);
//         } else {
//           final person = await getPerson(url.urlString);
//           _cache[url] = person;
//           final result =
//               FetchResult(persons: person, isRetrievedFromCache: false);
//           emit(result);
//         }
//       },
//     );
//   }
// }

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}
