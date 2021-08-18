part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const ALERT = _Paths.ALERT;
  static const SETTINGS = _Paths.SETTINGS;
}

abstract class _Paths {
  static const HOME = '/home';
  static const ALERT = '/alert';
  static const SETTINGS = '/settings';
}
