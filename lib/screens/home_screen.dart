// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zerohuecos/blocs/auth/auth_bloc.dart';
import '../blocs/pothole/pothole_bloc.dart';
import '../widgets/pothole_list.dart';

class HomeScreen extends StatelessWidget {
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
            child: GoogleMap(
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
