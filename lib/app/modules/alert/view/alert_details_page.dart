import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siemens_hackathon_safety_marker/app/global/util/size_config.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/bloc/alert_bloc.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/model/alert.dart';

class AlertDetailsPage extends StatefulWidget {
  const AlertDetailsPage({Key? key}) : super(key: key);

  @override
  _AlertDetailsPageState createState() => _AlertDetailsPageState();
}

class _AlertDetailsPageState extends State<AlertDetailsPage> {
  late final TextEditingController _titleController;

  late final TextEditingController _descriptionController;

  late String _alertType;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _alertType = '';
  }

  @override
  Widget build(BuildContext context) {
    log('Transitioned state: ${context.read<AlertBloc>().state == CurrentAlertState}');
    return BlocListener<AlertBloc, AlertState>(
      listener: (context, state) {},
      child: Scaffold(
        body: SizedBox(
          width: SizeConfig.width,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Report A disaster',
                    style: Theme.of(context).textTheme.headline4),

                _labelText(context, 'Title'),

                /// Title text form field
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.unitWidth * 10),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'e.g landslide on section B6',
                      hintStyle: Theme.of(context).textTheme.caption,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                _labelText(context, 'Type'),
                _selectDisasterType(),
                _labelText(context, 'Describe'),

                /// Describe text form field
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.unitWidth * 10),
                  child: TextFormField(
                    controller: _descriptionController,
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
                    /// Alert button
                    sendButton(
                      onPressed: updateAlert,
                      child: Text(
                        'ALERT',
                        style: Theme.of(context).primaryTextTheme.headline6,
                      ),
                      color: const Color(0xFF31EE7C),
                    ),
                    sendButton(
                        onPressed: () {},
                        child: const Text(
                          'Just alert',
                        ),
                        color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateAlert() {
    final initialAlert = BlocProvider.of<AlertBloc>(context).state.alert;
    BlocProvider.of<AlertBloc>(context)
        .add(UpdateAlertEvent(initialAlert.copyWith(
      title: _titleController.text,
      description: _descriptionController.text,
      type: _alertType,
    )));
  }

  Widget _labelText(BuildContext context, String text) {
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

  Widget _selectDisasterType() {
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
