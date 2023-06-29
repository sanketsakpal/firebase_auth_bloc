import 'package:firebase_auth_bloc/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_auth_bloc/blocs/auth_bloc/auth_state.dart';
import 'package:firebase_auth_bloc/pages/home_page.dart';
import 'package:firebase_auth_bloc/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  static const String routName = '/';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        debugPrint("listener:$state");
        if (state.authStatus == AuthStatus.unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            // YoutubeBlocAndCubitExample.routeName,
            SignInPage.routeName,
            (route) {
              debugPrint("route.settings.name: $route.settings.name");
              debugPrint(
                  'modelRoute: ${ModalRoute.of(context)!.settings.name}');
              return route.settings.name ==
                      ModalRoute.of(context)!.settings.name
                  ? true
                  : false;
            },
          );
        } else if (state.authStatus == AuthStatus.authenticated) {
          Navigator.pushNamed(context, HomePage.routeName);
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
