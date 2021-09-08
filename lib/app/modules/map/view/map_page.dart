import 'dart:developer';
import 'dart:typed_data';

import 'package:authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/map/bloc/map_bloc.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: MapBloc(context.read<AuthenticationRepository>()),
      child: const MapView(),
    );
  }
}

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is! MapInitial) {
            return GoogleMap(
              mapType: MapType.satellite,
              initialCameraPosition: CameraPosition(
                target: state.currentPosition!,
                zoom: 19.151926040649414,
                tilt: 59.440717697143555,
              ),
              markers: state.markers ?? {},
              myLocationEnabled: true,
              indoorViewEnabled: true,
              onMapCreated: context.read<MapBloc>().onMapCreated,
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }

  Widget imageBuilder(Key key) {
    return FutureBuilder(
        key: key,
        builder: (context, snapshot) {
          return Container();
        });
  }
}
