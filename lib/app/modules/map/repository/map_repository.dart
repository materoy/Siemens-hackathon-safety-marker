import 'dart:developer';

import 'package:authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UpdateLocationFailed implements Exception {}

class MapRepository {
  MapRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore _firestore;

  Stream<Position> get streamPosition => Geolocator.getPositionStream();

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location Services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are denied forever');
    }

    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Stream<List<User>> get usersStream =>
      _firestore.collection('USERS').snapshots().map((event) => event.docs
          .map((userSnapshot) => User.fromMap(userSnapshot.data()))
          .toList());

  // Stream get broadcastLocation =>
  //     Geolocator.getPositionStream().map((event) => _firestore
  //         .collection('USERS')
  //         .doc('ad')
  //         .update({'latLng': GeoPoint(event.latitude, event.longitude)}));

  Future updateUserPosition(
      {required LatLng position, required String uid}) async {
    try {
      await _firestore
          .collection('USERS')
          .doc(uid)
          .update({'latLng': GeoPoint(position.latitude, position.longitude)});
      log('Updating user location');
    } catch (e) {
      throw UpdateLocationFailed();
    }
  }
}
