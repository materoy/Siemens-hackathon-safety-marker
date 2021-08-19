import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siemens_hackathon_safety_marker/app/global/util/size_config.dart';

class AlertDetailsPage extends StatelessWidget {
  const AlertDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: SizeConfig.width,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Report A disaster',
                  style: Theme.of(context).textTheme.headline4),

              labelText(context, 'Title'),

              /// Title text form field
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.unitWidth * 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'e.g landslide on section B6',
                    hintStyle: Theme.of(context).textTheme.caption,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              labelText(context, 'Type'),
              const SelectDisasterTypeDropdown(),
              labelText(context, 'Describe'),

              /// Describe text form field
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.unitWidth * 10),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText:
                        '(optiona) write a short description of the disaster',
                    hintStyle: Theme.of(context).textTheme.caption,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  sendButton(
                    onPressed: () {},
                    child: Text(
                      'ALERT',
                      style: Theme.of(context).primaryTextTheme.headline6,
                    ),
                    color: const Color(0xFF31EE7C),
                  ),
                  sendButton(
                      onPressed: () {},
                      child: const Text(
                        "I dont't know just alert",
                      ),
                      color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget labelText(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.only(left: SizeConfig.unitWidth * 15),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget sendButton(
      {required VoidCallback onPressed,
      required Widget child,
      required Color color}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: color,
          minimumSize:
              Size(SizeConfig.unitWidth * 35.0, SizeConfig.unitHeight * 8.0)),
      onPressed: onPressed,
      child: child,
    );
  }
}

class SelectDisasterTypeDropdown extends StatelessWidget {
  const SelectDisasterTypeDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.unitWidth * 10),
      child: DropdownButtonFormField<String>(
        icon: const Icon(CupertinoIcons.chevron_down_circle),
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: 'disaster type',
          hintStyle: Theme.of(context).textTheme.caption,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: items(),
      ),
    );
  }

  List<DropdownMenuItem<String>> items() => const [
        DropdownMenuItem<String>(
          value: 'fire',
          child: Text('Fire'),
        ),
        DropdownMenuItem<String>(
          value: 'landslide',
          child: Text('Landslide'),
        ),
        DropdownMenuItem<String>(
          value: 'thunderstorm',
          child: Text('Thunderstorm'),
        ),
      ];
}
