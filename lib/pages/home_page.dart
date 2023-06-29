import 'package:firebase_auth_bloc/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_auth_bloc/blocs/auth_bloc/auth_event.dart';
import 'package:firebase_auth_bloc/pages/from_validation_bloc.dart';
import 'package:firebase_auth_bloc/pages/from_validation_cubit.dart';
import 'package:firebase_auth_bloc/pages/profile_page.dart';
import 'package:firebase_auth_bloc/pages/youtube_bloc_and_cubit_example.dart';
import 'package:firebase_auth_bloc/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/HomePage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequestedEvent());
              },
              icon: const Icon(Icons.exit_to_app),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              icon: const Icon(Icons.account_circle),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Homepage'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, FormValidationCubitScreen.routeName);
                  },
                  child: const Text("cubit validation")),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, FormValidationBlocScreen.routeName);
                },
                child: const Text("bloc validation"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, YoutubeBlocAndCubitExample.routeName);
                },
                child: const Text("Notes"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ViewHomePage.routeName);
                },
                child: const Text("login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
