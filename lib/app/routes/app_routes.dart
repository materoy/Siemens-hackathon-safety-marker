part of 'app_pages.dart';

// ignore_for_file: constant_identifier_names

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const ALERT = _Paths.ALERT;
  static const SETTINGS = _Paths.SETTINGS;
  static const ALERT_RESPONSE = _Paths.ALERT_RESPONSE;
  static const ALERT_DETAILS = _Paths.ALERT_DETAILS;
  static const RESCUE = _Paths.RESCUE;
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const SAFETY = _Paths.SAFETY;
  static const MAP = _Paths.MAP;
}

abstract class _Paths {
  static const HOME = '/home';
  static const ALERT = '/alert';
  static const SETTINGS = '/settings';
  static const ALERT_RESPONSE = '/alert_response';
  static const ALERT_DETAILS = '/alert_details';
  static const RESCUE = '/rescue';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const SAFETY = '/safety';
  static const MAP = '/map';
}
