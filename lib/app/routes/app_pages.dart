import 'package:flutter/material.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/alert.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/home/home.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/login/login.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/signup/signup.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/settings/settings.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.ALERT;

  static Map<String, Widget Function(BuildContext context)> routes = {
    _Paths.HOME: (_) => const HomePage(),
    _Paths.ALERT: (_) => const AlertPage(),
    _Paths.SETTINGS: (_) => const SettingsPage(),
    _Paths.ALERT_DETAILS: (_) => const AlertDetailsPage(),
    _Paths.ALERT_RESPONSE: (_) => const AlertResponsePage(),
    _Paths.USERS_WELFARE: (_) => const UsersWealfarePage(),
    _Paths.RESCUE: (_) => const RescuePage(),
    _Paths.LOGIN: (_) => const LoginPage(),
    _Paths.SIGNUP: (_) => const SignupPage(),
  };
}
