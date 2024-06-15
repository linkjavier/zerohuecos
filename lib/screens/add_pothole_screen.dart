import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../blocs/pothole/pothole_bloc.dart';
import '../models/pothole.dart';

class AddPotholeScreen extends StatefulWidget {
  @override
  _AddPotholeScreenState createState() => _AddPotholeScreenState();
}

class _AddPotholeScreenState extends State<AddPotholeScreen> {
  final TextEditingController _nameController = TextEditingController();

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si los servicios de ubicación están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Los servicios de ubicación no están habilitados, se puede mostrar un mensaje o intentar habilitarlos.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Los servicios de ubicación están deshabilitados.')),
      );
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Los permisos están denegados, se puede mostrar un mensaje
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permiso de ubicación denegado.')),
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Los permisos están denegados permanentemente, se puede mostrar un mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Permiso de ubicación denegado permanentemente.')),
      );
      return null;
    }

    // Cuando los permisos están concedidos, obtener la posición actual
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Pothole')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final name = _nameController.text;
                final position = await _determinePosition();

                if (position != null) {
                  final pothole = Pothole(
                    id: '',
                    name: name,
                    timestamp: DateTime.now(),
                    location: GeoPoint(position.latitude, position.longitude),
                  );
                  context.read<PotholeBloc>().add(AddPothole(pothole));
                  Navigator.pop(context);
                }
              },
              child: Text('Add Pothole'),
            ),
          ],
        ),
      ),
    );
  }
}
