import 'package:flutter/material.dart';
import 'package:siemens_hackathon_safety_marker/app/global/util/size_config.dart';
import 'package:siemens_hackathon_safety_marker/app/routes/app_pages.dart';

class AlertResponsePage extends StatelessWidget {
  const AlertResponsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: SizeConfig.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.unitWidth * 8),
                child: Text(
                  "There's a landslide at mining area B7",
                  style: Theme.of(context).textTheme.headline6!.copyWith(),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                'Are you safe ?',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              MarkerButton(
                text: 'YES',
                color: Colors.green,
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, Routes.MAP),
              ),
              MarkerButton(
                text: 'NO',
                color: Colors.red,
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, Routes.RESCUE),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MarkerButton extends StatelessWidget {
  const MarkerButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.color})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(.2), width: 6),
      ),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color.withOpacity(.5), width: 4),
          boxShadow: const [
            BoxShadow(blurRadius: 10, spreadRadius: 8, color: Colors.black12)
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            minimumSize:
                Size(SizeConfig.unitWidth * 45, SizeConfig.unitWidth * 45),
            primary: color,
          ),
          child: Text(
            text,
            style: Theme.of(context)
                .primaryTextTheme
                .headline3!
                .copyWith(fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
