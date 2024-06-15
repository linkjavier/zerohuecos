// lib/models/pothole.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Pothole {
  final String id;
  final String name;
  final DateTime timestamp;
  final GeoPoint location;

  Pothole({
    required this.id,
    required this.name,
    required this.timestamp,
    required this.location,
  });

  factory Pothole.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Pothole(
      id: doc.id,
      name: data['name'],
      timestamp: data['timestamp'].toDate(),
      location: data['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'timestamp': timestamp,
      'location': location,
    };
  }
}
