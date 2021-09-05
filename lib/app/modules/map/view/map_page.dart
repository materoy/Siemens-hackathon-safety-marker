import 'dart:developer';

import 'package:authentication/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

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
              onMapCreated: context.read<MapBloc>().onMapCreated,
              onLongPress: (latLng) {
                log('Tracking other users');
                context.read<MapBloc>().add(TrackUsersEvent());
              },
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}

// class _MapPageState extends State<MapPage> {
//   final Completer<GoogleMapController> _controller = Completer();

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: _controller.complete,
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToCurrentPosition,
//         label: const Text('To the lake!'),
//         icon: const Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<Position> _determineLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();

//     if (!serviceEnabled) {
//       return Future.error('Location Services are disabled');
//     }

//     permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();

//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location permissions are denied forever');
//     }

//     return Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }

//   Future<void> _goToCurrentPosition() async {
//     // ignore: omit_local_variable_types
//     final GoogleMapController controller = await _controller.future;

//     final CameraPosition currentPosition;
//     await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
