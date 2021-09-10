import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/model/model.dart';

class AlertRepository {
  AlertRepository({FirebaseFirestore? firestore, FirebaseStorage? storage})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  // ignore: constant_identifier_names
  static const ALERTS_COLLECTION = 'alerts';

  /// Creates an instance of a new alert in the database
  /// Returns is documentId
  Future<String> createAlert(Alert alert) async {
    final documentReference =
        await _firestore.collection(ALERTS_COLLECTION).add(alert.toMap());

    return documentReference.id;
  }

  Future<void> updateAlertDetails(Alert alert, List<Uint8List>? images) async {
    final imagesUrl = List<String>.empty(growable: true);
    if (images != null) {
      for (var i = 0; i < images.length; i++) {
        final storageReference =
            _storage.ref('$ALERTS_COLLECTION/${alert.alertId}/$i');
        final uploadTask = await storageReference.putData(images[i]);
        final imageUrl = await uploadTask.ref.getDownloadURL();
        imagesUrl.add(imageUrl);
      }
    }
    await _firestore
        .collection(ALERTS_COLLECTION)
        .doc(alert.alertId)
        .update(alert.copyWith(images: imagesUrl).toMap());
  }

  /// Sets the alert current value to false
  Future<void> disableAlert(Alert alert) async {
    await _firestore
        .collection(ALERTS_COLLECTION)
        .doc(alert.alertId)
        .update(alert.copyWith(active: false).toMap());
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
