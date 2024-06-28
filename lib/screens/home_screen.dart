import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zerohuecos/blocs/auth/auth_bloc.dart';
import '../blocs/pothole/pothole_bloc.dart';
import '../widgets/pothole_list.dart';
import '../blocs/map/map_bloc.dart';
import '../blocs/map/map_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ZeroHuecos',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthSignOutRequested());
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Expanded(
                        child: BlocListener<MapBloc, MapState>(
                          listener: (context, state) {
                            if (state is MapPotholeLocated) {
                              _mapController
                                  .animateCamera(CameraUpdate.newCameraPosition(
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
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: GoogleMap(
                                onMapCreated: (controller) {
                                  _mapController = controller;
                                },
                                initialCameraPosition: const CameraPosition(
                                  target: LatLng(0, 0),
                                  zoom: 2,
                                ),
                                markers: context.watch<PotholeBloc>().state
                                        is PotholeLoaded
                                    ? (context.read<PotholeBloc>().state
                                            as PotholeLoaded)
                                        .potholes
                                        .map((pothole) => Marker(
                                              markerId: MarkerId(pothole.id),
                                              position: LatLng(
                                                pothole.location.latitude,
                                                pothole.location.longitude,
                                              ),
                                              infoWindow: InfoWindow(
                                                title: pothole.name,
                                                snippet: pothole.timestamp
                                                    .toString(),
                                              ),
                                            ))
                                        .toSet()
                                    : {},
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: PotholeList()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[900],
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add_pothole');
        },
      ),
    );
  }
}
