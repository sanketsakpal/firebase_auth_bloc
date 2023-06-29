import 'package:firebase_auth_bloc/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_auth_bloc/blocs/profile_cubit/profile_cubit.dart';
import 'package:firebase_auth_bloc/blocs/profile_cubit/profile_state.dart';
import 'package:firebase_auth_bloc/utils/error_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/ProfilePage';
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    getProfile();
    super.initState();
  }

  void getProfile() {
    final uid = context.read<AuthBloc>().state.user!.uid;
    debugPrint('Uid:$uid');
    context.read<ProfileCubit>().getProfile(uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile "),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.profileStatus == ProfileStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          if (state.profileStatus == ProfileStatus.initial) {
            return Container();
          } else if (state.profileStatus == ProfileStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.profileStatus == ProfileStatus.error) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/error.png',
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Text(
                    'oops!\n try again ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            );
          }
          return Center(
            child: Card(
              elevation: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    elevation: 16,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(80)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading.gif',
                          image: state.user.profileImage,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "id:- ${state.user.id}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "name:- ${state.user.name}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "email:- ${state.user.email}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "point:- ${state.user.point}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "rank:- ${state.user.rank}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
