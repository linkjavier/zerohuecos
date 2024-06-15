// lib/repositories/pothole_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pothole.dart';

class PotholeRepository {
  final CollectionReference _potholeCollection =
      FirebaseFirestore.instance.collection('potholes');

  Future<void> addPothole(Pothole pothole) async {
    await _potholeCollection.add(pothole.toMap());
  }

  Stream<List<Pothole>> getPotholes() {
    return _potholeCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Pothole.fromDocument(doc)).toList();
    });
  }
}
