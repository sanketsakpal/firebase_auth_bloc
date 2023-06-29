import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_bloc/apis/login_api.dart';
import 'package:firebase_auth_bloc/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_auth_bloc/blocs/bloc/action_bloc.dart';
import 'package:firebase_auth_bloc/blocs/names_cubit/names_cubit.dart';
import 'package:firebase_auth_bloc/blocs/person_bloc/person_bloc.dart';
import 'package:firebase_auth_bloc/blocs/profile_cubit/profile_cubit.dart';
import 'package:firebase_auth_bloc/blocs/sign_in_cubit/sign_in_cubit.dart';
import 'package:firebase_auth_bloc/blocs/sign_up_cubit/sign_up_cubit.dart';
import 'package:firebase_auth_bloc/blocs/validation_bloc/validation_bloc.dart';
import 'package:firebase_auth_bloc/firebase_options.dart';
import 'package:firebase_auth_bloc/pages/from_validation_bloc.dart';
import 'package:firebase_auth_bloc/pages/from_validation_cubit.dart';
import 'package:firebase_auth_bloc/pages/home_page.dart';
import 'package:firebase_auth_bloc/pages/sign_in_page.dart';
import 'package:firebase_auth_bloc/pages/sign_up_page.dart';
import 'package:firebase_auth_bloc/pages/splash_page.dart';
import 'package:firebase_auth_bloc/pages/youtube_bloc_and_cubit_example.dart';
import 'package:firebase_auth_bloc/repositories/auth_repository.dart';
import 'package:firebase_auth_bloc/repositories/profile_repository.dart';
import 'package:firebase_auth_bloc/views/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        RepositoryProvider(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignInCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignUpCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(
              profileRepository: context.read<ProfileRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ValidationBloc(),
          ),
          BlocProvider(
            create: (context) => NamesCubit(),
          ),
          BlocProvider(
            create: (context) => PersonsBloc(),
          ),
          BlocProvider(
            create: (context) => ActionBloc(
              loginProtocol: LoginApi(),
              notesApiProtocol: NoteApi(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Firebase auth ',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashPage(),
          routes: {
            SignUpPage.routeName: (context) => const SignUpPage(),
            SignInPage.routeName: (context) => const SignInPage(),
            HomePage.routeName: (context) => const HomePage(),
            ViewHomePage.routeName: (context) => const ViewHomePage(),
            FormValidationCubitScreen.routeName: (context) =>
                FormValidationCubitScreen(),
            FormValidationBlocScreen.routeName: (context) =>
                const FormValidationBlocScreen(),
            YoutubeBlocAndCubitExample.routeName: (context) =>
                const YoutubeBlocAndCubitExample()
          },
        ),
      ),
    );
  }
}
