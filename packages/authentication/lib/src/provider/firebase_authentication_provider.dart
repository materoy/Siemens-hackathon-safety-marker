import 'package:firebase_auth/firebase_auth.dart';
import 'package:authentication/src/model/user.dart' as user;

class SignupUnsuccessfull implements Exception {}

/// The authentication provider exposes these function to the repository
/// [Signup, login, addUserToFirestore ]
class FirebaseAuthenticationProvider {
  FirebaseAuthenticationProvider({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;

  Future<User?> signup(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      throw SignupUnsuccessfull();
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      throw SignupUnsuccessfull();
    }
  }
}
