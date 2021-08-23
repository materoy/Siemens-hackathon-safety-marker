import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/model/model.dart';

class AlertRepository {
  AlertRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const ALERTS_COLLECTION = 'alerts';

  /// Creates an instance of a new alert in the database
  /// Returns is documentId
  Future<String> createAlert(Alert alert) async {
    final documentReference =
        await _firestore.collection(ALERTS_COLLECTION).add(alert.toMap());

    return documentReference.id;
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
