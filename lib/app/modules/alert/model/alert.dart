import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Alert extends Equatable {
  const Alert({
    this.alertId,
    required this.creatorId,
    this.title,
    this.type,
    this.description,
    required this.time,
    this.active = true,
    this.images,
  });

  factory Alert.fromMap(Map<String, dynamic> alertMap) {
    return Alert(
      alertId: alertMap['alertId'] as String?,
      creatorId: alertMap['creatorId'] as String,
      time: (alertMap['time'] as Timestamp).toDate(),
      active: alertMap['active'] as bool,
      description: alertMap['description'] as String?,
      title: alertMap['title'] as String?,
      type: alertMap['type'] as String?,
      images: (alertMap['images'] as List?)
          ?.map((dynamic e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'alertId': alertId,
      'creatorId': creatorId,
      'title': title,
      'type': type,
      'description': description,
      'time': time,
      'active': active,
      'images': images,
    };
  }

  final String? alertId;
  final String creatorId;
  final String? title;
  final String? type;
  final String? description;
  final DateTime time;
  final bool active;
  final List<String>? images;

  static Alert empty = Alert(
      time: DateTime.now(),
      creatorId: '',
      alertId: '',
      active: false,
      description: '',
      title: '',
      type: '');

  @override
  List<Object?> get props =>
      [alertId, time, creatorId, active, description, title, type, images];

  Alert copyWith({
    final String? alertId,
    final String? title,
    final String? type,
    final String? description,
    final DateTime? time,
    final bool? active,
    final List<String>? images,
  }) {
    return Alert(
      time: time ?? this.time,
      alertId: alertId ?? this.alertId,
      creatorId: creatorId,
      active: active ?? this.active,
      description: description ?? this.description,
      title: title ?? this.title,
      type: type ?? this.type,
      images: images ?? this.images,
    );
  }
}
