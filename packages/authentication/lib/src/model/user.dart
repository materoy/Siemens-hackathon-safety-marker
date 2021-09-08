import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class User extends Equatable {
  const User(
      {this.uid,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      this.badgeNumber,
      this.latLng,
      this.photoUrl,
      this.safe = false});

  factory User.fromMap(Map<String, dynamic> userMap) {
    return User(
      uid: userMap['uid'],
      firstName: userMap['firstName'],
      lastName: userMap['lastName'],
      email: userMap['email'],
      phone: userMap['phone'],
      badgeNumber: userMap['badgeNumber'],
      latLng: (userMap['latLng'] as GeoPoint?).toLatLng(),
      photoUrl: userMap['photoUrl'],
      safe: userMap['safe'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'badgeNumber': badgeNumber,
      'latLng': latLng.toGeoPoint(),
      'photoUrl': photoUrl,
      'safe': safe,
    };
  }

  static const empty = User(firstName: '', lastName: '', email: '', phone: '');

  final String? uid;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? badgeNumber;
  final LatLng? latLng;
  final String? photoUrl;
  final bool safe;

  User copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? badgeNumber,
    LatLng? latLng,
    String? photoUrl,
    bool? safe,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      badgeNumber: badgeNumber ?? this.badgeNumber,
      uid: uid ?? this.uid,
      latLng: latLng ?? this.latLng,
      photoUrl: photoUrl ?? this.photoUrl,
      safe: safe ?? this.safe,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        firstName,
        lastName,
        email,
        phone,
        badgeNumber,
        latLng,
        photoUrl,
        safe
      ];
}

extension on GeoPoint? {
  LatLng? toLatLng() =>
      this != null ? LatLng(this!.latitude, this!.longitude) : null;
}

extension on LatLng? {
  GeoPoint? toGeoPoint() =>
      this != null ? GeoPoint(this!.latitude, this!.longitude) : null;
}
