import 'package:flutter/material.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/home/view/home_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static Map<String, Widget Function(BuildContext context)> routes = {
    _Paths.HOME: (_) => const HomePage(),
    // _Paths.ALERT: (_)
  };
}
