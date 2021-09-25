import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siemens_hackathon_safety_marker/app/global/app_bloc/app_bloc.dart';
import 'package:siemens_hackathon_safety_marker/app/global/util/size_config.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/bloc/alert_bloc.dart';
import 'package:siemens_hackathon_safety_marker/app/routes/app_pages.dart';

import '../alert.dart';

class AlertDetailsPage extends StatefulWidget {
  const AlertDetailsPage({Key? key}) : super(key: key);

  @override
  _AlertDetailsPageState createState() => _AlertDetailsPageState();
}

class _AlertDetailsPageState extends State<AlertDetailsPage> {
  late final TextEditingController _titleController;

  late final TextEditingController _descriptionController;

  late String _alertType;

  late List<Uint8List> _images;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _alertType = '';
    _images = List<Uint8List>.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: SizeConfig.width,
            height: SizeConfig.unitHeight * 97,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Report A disaster',
                    style: Theme.of(context).textTheme.headline5),

                _labelText('Title'),

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

                _labelText('Type'),
                _selectDisasterType(),
                _labelText('Describe'),

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

                _labelText('Add images (optional)', fontSize: 12),

                /// The disaster images
                _disasterImages(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// Alert button
                    sendButton(
                      onPressed: _createAlert,
                      child: Text(
                        'ALERT',
                        style: Theme.of(context).primaryTextTheme.headline6,
                      ),
                      color: const Color(0xFF31EE7C),
                    ),
                    sendButton(
                        onPressed: () {
                          _createAlert();
                          Navigator.pushReplacementNamed(context, Routes.MAP);
                        },
                        child: const Text(
                          'Just alert \n without description',
                          textAlign: TextAlign.center,
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
    BlocProvider.of<AlertBloc>(context).add(UpdateAlertEvent(
        initialAlert.copyWith(
          title: _titleController.text,
          description: _descriptionController.text,
          type: _alertType,
        ),
        images: _images));
  }

  void _createAlert() {
    context.read<AlertBloc>().add(CreateAlertEvent(
          Alert(
            time: DateTime.now(),
            creatorId: context.read<AppBloc>().state.user.uid!,
            title: _titleController.text,
            description: _descriptionController.text,
            type: _alertType,
          ),
          images: _images,
        ));

    ThankyouDialog.show(context);
  }

  Widget _disasterImages() {
    return SizedBox(
      height: SizeConfig.unitHeight * 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _imageContainer(IconButton(
              onPressed: _addImages, icon: const Icon(CupertinoIcons.add))),
          ...List.generate(
              _images.length,
              (index) => Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      _imageContainer(
                          Image.memory(_images[index], fit: BoxFit.cover)),
                      IconButton(
                          onPressed: () {
                            /// Remove an image from list
                            setState(() {
                              _images.remove(_images[index]);
                            });
                          },
                          icon: const Icon(
                            Icons.cancel_rounded,
                            color: Colors.red,
                          ))
                    ],
                  ))
        ],
      ),
    );
  }

  Widget _imageContainer(Widget child) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: child,
        ),
      ),
    );
  }

  Future<void> _addImages() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      final pickedImageBytes = await pickedImage.readAsBytes();
      setState(() {
        _images.add(pickedImageBytes);
      });
    }
  }

  Widget _labelText(String text, {EdgeInsets? padding, double? fontSize}) {
    return Container(
      padding: padding ?? EdgeInsets.only(left: SizeConfig.unitWidth * 15),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style:
            Theme.of(context).textTheme.headline6!.copyWith(fontSize: fontSize),
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

class ThankyouDialog extends StatelessWidget {
  const ThankyouDialog({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) {
    return showCupertinoDialog<void>(
      context: context,
      builder: (context) => const ThankyouDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        title: const Text('Thank you'),
        content:
            const Text("Your alert may save a life it's very much appreciated"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, Routes.MAP);
              },
              child: const Text('Map')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushReplacementNamed(context, Routes.MAP);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              )),
        ]);
  }
}
