// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:siemens_hackathon_safety_marker/app/global/global.dart';
import 'package:siemens_hackathon_safety_marker/app/routes/app_pages.dart';

class RescuePage extends StatelessWidget {
  const RescuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: SizeConfig.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Need Rescue',
                    style: Theme.of(context).textTheme.headline5),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green.withOpacity(.3),
                        width: 8,
                      )),
                  child: ElevatedButton(
                      onPressed: () {
                        /// Invoke send rescue and show success dialog
                        /// afterwards
                        RescueSentDialog.show(context);
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          primary: Colors.green,
                          minimumSize: Size(SizeConfig.unitWidth * 45,
                              SizeConfig.unitWidth * 45)),
                      child: Text('RESCUE',
                          style: Theme.of(context).primaryTextTheme.headline4)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.unitWidth * 10),
                  child: Text(
                      "The rescue team will use this device's location to locate you please make sure your GPS is turned ON",
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center),
                ),
              ]),
        ),
      ),
    );
  }
}

class RescueSentDialog extends StatelessWidget {
  const RescueSentDialog({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showDialog<void>(
            context: context, builder: (context) => const RescueSentDialog())
        .then((value) => Navigator.pushReplacementNamed(context, Routes.MAP));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'The rescue team has been sent to your location hold tight',
                textAlign: TextAlign.center),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: () {}, child: const Text('Cancel')),
                TextButton(onPressed: () {}, child: const Text('Go to map')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
