import 'dart:math';

import 'package:flutter/material.dart';
import 'package:siemens_hackathon_safety_marker/app/global/util/size_config.dart';

class AlertResponsePage extends StatelessWidget {
  const AlertResponsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: SizeConfig.safeWidth,
              height: SizeConfig.safeHeight,
              child: Stack(
                children: List.generate(
                    10,
                    (index) => UserBubble(
                          name: 'John Doe',
                          location: 'Mining area B1',
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserBubble extends StatelessWidget {
  UserBubble({Key? key, required this.name, this.location}) : super(key: key);

  final String name;
  final String? location;

  final bool safe = Random().nextBool();
  final double sizeForSafe = SizeConfig.unitHeight * 10;
  final double sizeForUnsafe = SizeConfig.unitHeight * 14;

  double get bottomOffset => Random()
      .nextInt((SizeConfig.safeHeight - (safe ? sizeForSafe : sizeForUnsafe))
          .toInt())
      .toDouble();

  double get leftOffset => Random()
      .nextInt(
          (SizeConfig.safeWidth - (safe ? sizeForSafe : sizeForUnsafe)).toInt())
      .toDouble();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottomOffset,
      left: leftOffset,
      child: GestureDetector(
        onTap: () {
          openUserDialog(context);
        },
        child: Container(
          width: safe ? sizeForSafe : sizeForUnsafe,
          height:
              safe ? SizeConfig.unitHeight * 10 : SizeConfig.unitHeight * 12,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: safe ? Colors.red : Colors.green, width: 2),
              boxShadow: const [
                BoxShadow(blurRadius: 6, spreadRadius: 6, color: Colors.black26)
              ]),
          child: CircleAvatar(
            backgroundColor: safe ? Colors.green : Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 6),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
                const Spacer(),
                Text(
                  location ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .bodyText2!
                      .copyWith(fontSize: 8),
                ),
                const Spacer(flex: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openUserDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: name,
      barrierDismissible: true,
      pageBuilder: (context, animation, secondaryAnimation) {
        return UserPopupDialog(
          offset: Offset(leftOffset, bottomOffset),
        );
      },
    );
  }
}

class UserPopupDialog extends StatelessWidget {
  const UserPopupDialog({Key? key, required this.offset}) : super(key: key);

  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return Center(
      // offset: offset,
      child: SizedBox(
        width: SizeConfig.unitWidth * 20,
        height: SizeConfig.unitHeight * 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'name',
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
            const Spacer(),
            Text(
              "location ?? ''",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyText2!
                  .copyWith(fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }
}
