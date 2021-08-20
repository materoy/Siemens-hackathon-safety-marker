import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {this.uid,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      this.badgeNumber});

  factory User.fromMap(Map<String, dynamic> userMap) {
    return User(
        uid: userMap['uid'],
        firstName: userMap['firstName'],
        lastName: userMap['lastName'],
        email: userMap['email'],
        phone: userMap['phone'],
        badgeNumber: userMap['badgeNumber']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'badgeNumber': badgeNumber,
    };
  }

  static const empty = User(firstName: '', lastName: '', email: '', phone: '');

  final String? uid;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? badgeNumber;

  User copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? badgeNumber,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      badgeNumber: badgeNumber ?? this.badgeNumber,
      uid: uid ?? this.uid,
    );
  }

  @override
  List<Object?> get props =>
      [uid, firstName, lastName, email, phone, badgeNumber];
}
