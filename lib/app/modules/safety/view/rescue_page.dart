// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:siemens_hackathon_safety_marker/app/global/global.dart';

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
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        primary: Colors.green,
                        minimumSize: Size(SizeConfig.unitWidth * 45,
                            SizeConfig.unitWidth * 45)),
                    child: Text('RESCUE',
                        style: Theme.of(context).primaryTextTheme.headline4)),
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
