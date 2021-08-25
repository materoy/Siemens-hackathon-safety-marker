import 'package:equatable/equatable.dart';

class Alert extends Equatable {
  const Alert(
      {this.alertId,
      required this.creatorId,
      this.title,
      this.type,
      this.description,
      required this.time,
      this.current = true});

  factory Alert.fromMap(Map<String, dynamic> alertMap) {
    return Alert(
      alertId: alertMap['alertId'] as String?,
      creatorId: alertMap['creatorId'] as String,
      time: alertMap['time'] as DateTime,
      current: alertMap['current'] as bool,
      description: alertMap['description'] as String?,
      title: alertMap['title'] as String?,
      type: alertMap['type'] as String?,
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
      'current': current,
    };
  }

  final String? alertId;
  final String creatorId;
  final String? title;
  final String? type;
  final String? description;
  final DateTime time;
  final bool current;

  static Alert empty = Alert(
      time: DateTime.now(),
      creatorId: '',
      alertId: '',
      current: false,
      description: '',
      title: '',
      type: '');

  @override
  List<Object?> get props =>
      [alertId, time, creatorId, current, description, title, type];

  Alert copyWith({
    final String? alertId,
    final String? title,
    final String? type,
    final String? description,
    final DateTime? time,
    final bool? current,
  }) {
    return Alert(
      time: time ?? this.time,
      alertId: alertId ?? this.alertId,
      creatorId: creatorId,
      current: current ?? this.current,
      description: description ?? this.description,
      title: title ?? this.title,
      type: type ?? this.type,
    );
  }
}
