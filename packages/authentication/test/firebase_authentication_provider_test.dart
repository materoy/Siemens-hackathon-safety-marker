import 'package:authentication/src/provider/firebase_authentication_provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

main() async {
  group('Firebase authentication provider', () {
    final mockUser = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    FirebaseAuthenticationProvider _authProvider =
        FirebaseAuthenticationProvider(
            firebaseAuth: MockFirebaseAuth(),
            firestore: FakeFirebaseFirestore());
    test('signs up successfully', () async {
      final actual =
          await _authProvider.signup('bob@somedomain.com', 'password');
      // expect(actual, mockUser);
    });
  });
}
