import 'dart:developer';

import 'package:cache/cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authentication/src/model/user.dart' as user_model;
import 'package:flutter/foundation.dart';

class SignupFailed implements Exception {}

class LoginFailed implements Exception {}

class AddUserToFirebaseFailed implements Exception {}

class GetUserFailed implements Exception {}

class LogoutFailed implements Exception {}

/// The authentication provider exposes these function to the repository
/// [Signup, login, addUserToFirestore ]
class FirebaseAuthenticationProvider {
  FirebaseAuthenticationProvider(
      {FirebaseAuth? firebaseAuth,
      FirebaseFirestore? firestore,
      CacheClient? cache})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _cache = cache ?? CacheClient();

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final CacheClient _cache;

  // ignore_for_file: constant_identifier_names
  static const String USERS_COLLECTION = 'users';

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  // Stream<user_model.User> user() async* {
  //   final String uid = await _firebaseAuth
  //       .authStateChanges()
  //       .map((user) => user != null ? user.uid : '')
  //       .first;
  //   if (uid != '') {
  //     yield* _firestore
  //         .collection(USERS_COLLECTION)
  //         .doc(uid)
  //         .snapshots()
  //         .map((snapshot) => user_model.User.fromMap(snapshot.data()!));
  //   } else {
  //     yield user_model.User.empty;
  //   }
  // }

  Stream<user_model.User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      var userFromFirebase = firebaseUser == null
          ? user_model.User.empty
          : firebaseUser.toUserModel;
      _cache.write<user_model.User>(
          key: userCacheKey, value: firebaseUser.toUserModel);

      return userFromFirebase;
    });
  }

  user_model.User get currentUser {
    return _cache.read<user_model.User>(key: userCacheKey) ??
        user_model.User.empty;
  }

  /// Returns current user stored in memory
  // user_model.User get currentUser {
  //   return _firebaseAuth.currentUser.toUserModel;
  //   // return _cache.read<user_model.User>(key: userCacheKey) ??
  //   // user_model.User.empty;
  // }

  Future<User?> signup(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      log(e.toString());
      throw SignupFailed();
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      log(e.toString());
      throw LoginFailed();
    }
  }

  Future<void> addUserToFirestore(user_model.User user) async {
    try {
      await _firestore
          .collection(USERS_COLLECTION)
          .doc(user.uid)
          .set(user.toMap());
    } catch (exception) {
      throw AddUserToFirebaseFailed();
    }
  }

  Future<user_model.User?> getUserFromFirestore(String uid) async {
    try {
      final DocumentSnapshot userSnapshot =
          await _firestore.collection(USERS_COLLECTION).doc(uid).get();
      if (userSnapshot.exists) {
        return user_model.User.fromMap(
            userSnapshot.data()! as Map<String, dynamic>);
      } else {
        throw GetUserFailed();
      }
    } catch (exception) {
      throw GetUserFailed();
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception {
      throw LogoutFailed();
    }
  }
}

extension on User? {
  user_model.User get toUserModel => this != null
      ? user_model.User(
          uid: this?.uid,
          firstName: this?.displayName ?? '',
          lastName: '',
          email: this!.email!,
          phone: this!.phoneNumber ?? '')
      : user_model.User.empty;
}
