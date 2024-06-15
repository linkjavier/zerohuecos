// lib/screens/add_pothole_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../blocs/pothole/pothole_bloc.dart';
import '../models/pothole.dart';

class AddPotholeScreen extends StatefulWidget {
  @override
  _AddPotholeScreenState createState() => _AddPotholeScreenState();
}

class _AddPotholeScreenState extends State<AddPotholeScreen> {
  final TextEditingController _nameController = TextEditingController();

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
                final position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                final pothole = Pothole(
                  id: '',
                  name: name,
                  timestamp: DateTime.now(),
                  location: GeoPoint(position.latitude, position.longitude),
                );
                context.read<PotholeBloc>().add(AddPothole(pothole));
                Navigator.pop(context);
              },
              child: Text('Add Pothole'),
            ),
          ],
        ),
      ),
    );
  }
}
