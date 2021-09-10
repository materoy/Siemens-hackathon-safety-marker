import 'package:authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/alert.dart';

class SafetyRepository {
  SafetyRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore _firestore;

  Stream<Alert?> get activeAlertsStream => _firestore
      .collection(AlertRepository.ALERTS_COLLECTION)
      .where('active', isEqualTo: true)
      // .orderBy('time')
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs.isNotEmpty
          ? Alert.fromMap(querySnapshot.docs.last.data())
              .copyWith(alertId: querySnapshot.docs.last.id)
          : null);

  Future<void> updateSafetyState(
      {required String uid, required bool safe}) async {
    await _firestore
        .collection(AuthenticationRepository.USERS_COLLECTION)
        .doc(uid)
        .update({'safe': safe});
  }
}
