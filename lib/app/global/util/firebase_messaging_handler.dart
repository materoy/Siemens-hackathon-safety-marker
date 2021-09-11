import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  log('Handling a background message: ${message.notification}');

  const platform = MethodChannel('com.siemens.hackathon/platform_interface');

  if (Platform.isAndroid) {
    await platform.invokeMethod<void>('bringToForeground');
  }
}
