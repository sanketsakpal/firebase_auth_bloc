// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:firebase_auth_bloc/blocs/profile_cubit/profile_state.dart';
import 'package:firebase_auth_bloc/model/custom_error.dart';
import 'package:firebase_auth_bloc/model/user_model.dart';
import 'package:firebase_auth_bloc/repositories/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;
  ProfileCubit({
    required this.profileRepository,
  }) : super(ProfileState.initial());

  Future<void> getProfile({required String uid}) async {
    emit(
      state.copyWith(profileStatus: ProfileStatus.loading),
    );
    try {
      final User user = await profileRepository.getProfile(uid: uid);
      emit(state.copyWith(profileStatus: ProfileStatus.loaded,user: user));
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          profileStatus: ProfileStatus.error,
          error: e,
        ),
      );
    }
  }
}
