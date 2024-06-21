import 'package:cloud_firestore/cloud_firestore.dart';

class Pothole {
  final String id;
  final String name;
  final DateTime timestamp;
  final GeoPoint location;
  final String city;
  final String state;
  final String street;
  final String streetNumber;
  final String postalCode;
  final String neighborhood;
  final List<String> photoUrls;
  final List<String> videoUrls;

  Pothole({
    required this.id,
    required this.name,
    required this.timestamp,
    required this.location,
    required this.city,
    required this.state,
    required this.street,
    required this.streetNumber,
    required this.postalCode,
    required this.neighborhood,
    this.photoUrls = const [],
    this.videoUrls = const [],
  });

  factory Pothole.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Pothole(
      id: doc.id,
      name: data['name'],
      timestamp: data['timestamp'].toDate(),
      location: data['location'],
      city: data['city'] ?? 'Ciudad desconocida',
      state: data['state'] ?? 'Estado desconocido',
      street: data['street'] ?? 'Calle desconocida',
      streetNumber: data['streetNumber'] ?? 'Número de calle desconocido',
      postalCode: data['postalCode'] ?? 'Código postal desconocido',
      neighborhood: data['neighborhood'] ?? 'Barrio desconocido',
      photoUrls: List<String>.from(data['photoUrls'] ?? []),
      videoUrls: List<String>.from(data['videoUrls'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'timestamp': timestamp,
      'location': location,
      'city': city,
      'state': state,
      'street': street,
      'streetNumber': streetNumber,
      'postalCode': postalCode,
      'neighborhood': neighborhood,
      'photoUrls': photoUrls,
      'videoUrls': videoUrls,
    };
  }
}
