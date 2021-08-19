import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siemens_hackathon_safety_marker/app/routes/app_pages.dart';

class MarkerBottomNavigationBar extends StatelessWidget {
  const MarkerBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 10,
      showUnselectedLabels: false,
      items: items(),
      currentIndex: currentIndex(context),
      onTap: (value) => navigateTo(context, value),
    );
  }

  void navigateTo(BuildContext context, int index) {
    if (ModalRoute.of(context)!.settings.name != routes[index]) {
      // Navigator.pushNamed(context, routes[index]);
      Navigator.pushReplacementNamed(context, routes[index]);
    }
  }

  static const List<String> routes = [
    Routes.ALERT,
    Routes.HOME,
    Routes.SETTINGS
  ];

  int currentIndex(BuildContext context) {
    for (final route in routes) {
      if (ModalRoute.of(context)!.settings.name == route) {
        return routes.indexOf(route);
      }
    }
    return 0;
  }

  List<BottomNavigationBarItem> items() {
    return [
      const BottomNavigationBarItem(
          label: 'Alert', icon: Icon(CupertinoIcons.dot_radiowaves_left_right)),
      const BottomNavigationBarItem(
          label: 'Home', icon: Icon(CupertinoIcons.home)),
      const BottomNavigationBarItem(
          label: 'Settings', icon: Icon(CupertinoIcons.settings)),
    ];
  }
}
