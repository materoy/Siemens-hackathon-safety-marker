import 'package:flutter/material.dart';
import 'package:siemens_hackathon_safety_marker/app/global/global.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MarkerBottomNavigationBar(),
    );
  }
}
