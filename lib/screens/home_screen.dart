// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zerohuecos/blocs/auth/auth_bloc.dart';
import '../blocs/pothole/pothole_bloc.dart';
import '../widgets/pothole_list.dart';
import '../blocs/map/map_bloc.dart';
import '../blocs/map/map_state.dart';
// import '../widgets/pothole_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ZeroHuecos'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthSignOutRequested());
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocListener<MapBloc, MapState>(
              listener: (context, state) {
                if (state is MapPotholeLocated) {
                  _mapController.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(
                        state.pothole.location.latitude,
                        state.pothole.location.longitude,
                      ),
                      zoom: state.zoom,
                    ),
                  ));
                }
              },
              child: GoogleMap(
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 2,
                ),
                markers: context.watch<PotholeBloc>().state is PotholeLoaded
                    ? (context.read<PotholeBloc>().state as PotholeLoaded)
                        .potholes
                        .map((pothole) => Marker(
                              markerId: MarkerId(pothole.id),
                              position: LatLng(
                                pothole.location.latitude,
                                pothole.location.longitude,
                              ),
                              infoWindow: InfoWindow(
                                title: pothole.name,
                                snippet: pothole.timestamp.toString(),
                              ),
                            ))
                        .toSet()
                    : {},
              ),
            ),
          ),
          Expanded(child: PotholeList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add_pothole');
        },
      ),
    );
  }
}
