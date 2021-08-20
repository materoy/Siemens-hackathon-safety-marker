import 'package:authentication/src/provider/firebase_authentication_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Firebase authentication provider', () {
    FirebaseAuthenticationProvider _authProvider =
        FirebaseAuthenticationProvider();
    test('signs up successfully', () {
      expect(() => _authProvider.signup('email', 'password'),
          isA<firebase_auth.User>());
    });
  });
}
