import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/model/model.dart';

class AlertRepository {
  AlertRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  // ignore: constant_identifier_names
  static const ALERTS_COLLECTION = 'alerts';

  /// Creates an instance of a new alert in the database
  /// Returns is documentId
  Future<String> createAlert(Alert alert) async {
    final documentReference =
        await _firestore.collection(ALERTS_COLLECTION).add(alert.toMap());

    return documentReference.id;
  }

  Future<void> updateAlertDetails(Alert alert) async {
    await _firestore
        .collection(ALERTS_COLLECTION)
        .doc(alert.alertId)
        .update(alert.toMap());
  }

  /// Sets the alert current value to false
  Future<void> disableAlert(Alert alert) async {
    await _firestore
        .collection(ALERTS_COLLECTION)
        .doc(alert.alertId)
        .update(alert.copyWith(current: false).toMap());
  }

  Stream<List<Alert>> alertsStream() async* {
    yield* _firestore.collection(ALERTS_COLLECTION).snapshots().map((event) {
      return event.docs
          .where((element) => element.data()['current'] == true)
          .map((e) => Alert.fromMap(e.data()))
          .toList();
    });
  }
}
