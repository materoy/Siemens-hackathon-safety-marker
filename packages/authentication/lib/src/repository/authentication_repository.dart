import 'dart:developer';

import 'package:authentication/src/provider/firebase_authentication_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:authentication/src/model/user.dart' as user_model;

class AuthenticationRepository {
  AuthenticationRepository(
      {FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuthProvider = FirebaseAuthenticationProvider(
            firebaseAuth: firebaseAuth, firestore: firestore);
  final FirebaseAuthenticationProvider _firebaseAuthProvider;
  static String get USERS_COLLECTION =>
      FirebaseAuthenticationProvider.USERS_COLLECTION;

  // Stream<user_model.User> user() async* {
  //   yield* _firebaseAuthProvider.user();
  // }
  Stream<user_model.User> get user => _firebaseAuthProvider.user;

  /// Returns current user stored in memory
  user_model.User get currentUser => _firebaseAuthProvider.currentUser;

  Future<user_model.User?> login(String email, String password) async {
    User? userLogin = await _firebaseAuthProvider.login(email, password);
    if (userLogin != null) {
      return _firebaseAuthProvider.getUserFromFirestore(userLogin.uid);
    }
  }

  Future<user_model.User?> signup(user_model.User user, String password) async {
    try {
      User? userLogin =
          await _firebaseAuthProvider.signup(user.email, password);
      if (userLogin != null) {
        final userWithId = user.copyWith(uid: userLogin.uid);
        await _firebaseAuthProvider.addUserToFirestore(userWithId);
        return userWithId;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> logout() async {
    await _firebaseAuthProvider.logout();
  }
}
