// lib/screens/pothole_details_screen.dart
import 'package:flutter/material.dart';
import '../models/pothole.dart';

class PotholeDetailsScreen extends StatelessWidget {
  final Pothole pothole;

  PotholeDetailsScreen({required this.pothole});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pothole.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${pothole.name}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Fecha y Hora: ${pothole.timestamp}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(
                'Ubicación: (${pothole.location.latitude}, ${pothole.location.longitude})',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Ciudad: ${pothole.city}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Estado: ${pothole.state}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Calle: ${pothole.street}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Número de Calle: ${pothole.streetNumber}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Código Postal: ${pothole.postalCode}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Barrio: ${pothole.neighborhood}',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
