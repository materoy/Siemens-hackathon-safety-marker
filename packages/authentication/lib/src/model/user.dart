import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.uid,
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

  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? badgeNumber;

  @override
  List<Object?> get props =>
      [uid, firstName, lastName, email, phone, badgeNumber];
}
