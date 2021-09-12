import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/alert.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/model/model.dart';

class HomeRepository {
  HomeRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<List<Alert>> get getDisasters => _firestore
      .collection(AlertRepository.ALERTS_COLLECTION)
      .orderBy('time')
      .snapshots()
      .map((querySnaphot) => querySnaphot.docs
          .map((documentSnapshot) => Alert.fromMap(documentSnapshot.data()))
          .toList());
}
