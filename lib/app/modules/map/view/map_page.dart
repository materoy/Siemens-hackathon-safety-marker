import 'package:authentication/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:siemens_hackathon_safety_marker/app/global/app_bloc/app_bloc.dart';
import 'package:siemens_hackathon_safety_marker/app/global/util/size_config.dart';
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
        buildWhen: (previous, current) {
          return listEquals(
              previous.markers?.toList(), current.markers?.toList());
          // return previous.markers != current.markers;
        },
        builder: (context, state) {
          if (state is! MapInitial && state.currentPosition != null) {
            final markers = state.markers ?? {};
            final user = context.read<AppBloc>().state.user;
            if (state.currentPosition != null) {
              markers.add(Marker(
                  markerId: MarkerId(user.uid!),
                  position: state.currentPosition!,
                  flat: true,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange)));
            }
            return Stack(
              children: [
                GoogleMap(
                  mapType: MapType.satellite,
                  initialCameraPosition: CameraPosition(
                    target: state.currentPosition!,
                    zoom: 19.151926040649414,
                    tilt: 59.440717697143555,
                  ),
                  markers: markers,
                  myLocationEnabled: true,
                  indoorViewEnabled: true,
                  onMapCreated: context.read<MapBloc>().onMapCreated,
                ),
                Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: SizeConfig.unitHeight * 4),
                    child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFFFFF).withOpacity(.3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Colors.red, width: 2))),
                        child: const Text("I'm Now Safe")))
              ],
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
