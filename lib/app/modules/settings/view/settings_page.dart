import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:siemens_hackathon_safety_marker/app/global/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MarkerBottomNavigationBar(),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationRepository>().logout();
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
