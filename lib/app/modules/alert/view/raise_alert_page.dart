import 'package:flutter/material.dart';
import 'package:siemens_hackathon_safety_marker/app/global/util/size_config.dart';
import 'package:siemens_hackathon_safety_marker/app/global/widgets/bottom_navigation_bar.dart';
import 'package:siemens_hackathon_safety_marker/app/routes/app_pages.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MarkerBottomNavigationBar(),
      body: SizedBox(
        width: SizeConfig.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Raise alert'),
            SizedBox(height: SizeConfig.unitHeight * 4),
            AlertButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.ALERT_DETAILS, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AlertButton extends StatelessWidget {
  const AlertButton({Key? key, required this.onPressed, this.child})
      : super(key: key);

  final VoidCallback onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: SizeConfig.unitWidth * 60,
          height: SizeConfig.unitWidth * 60,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.red.withOpacity(.3), width: 10),
              shape: BoxShape.circle,
              color: Colors.transparent),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.red.withOpacity(.7), width: 10),
                shape: BoxShape.circle,
                color: Colors.transparent),
            child: const CircleAvatar(
              backgroundColor: Colors.red,
            ),
          )),
    );
  }
}
