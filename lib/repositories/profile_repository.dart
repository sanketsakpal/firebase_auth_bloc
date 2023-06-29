// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_bloc/constant/db_constant.dart';
import 'package:firebase_auth_bloc/model/custom_error.dart';
import 'package:firebase_auth_bloc/model/user_model.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;
  ProfileRepository({
    required this.firebaseFirestore,
  });
  Future<User> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot userDoc = await usersRef.doc(uid).get();
      if (userDoc.exists) {
        final currentUser = User.fromDoc(userDoc);
        return currentUser;
      }

      throw ' user not found ';
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: 'exception', message: e.toString(), plugin: 'server error');
    }
  }
}
