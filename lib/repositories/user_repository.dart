// lib/repositories/user_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserRepository {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    await _userCollection.doc(user.id).set(user.toMap());
  }

//Necesitamos obtener todos los usuarios?
  Stream<List<UserModel>> getUsers() {
    return _userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromDocument(doc)).toList();
    });
  }

  Stream<UserModel> getUser(String userId) {
    return _userCollection
        .doc(userId)
        .snapshots()
        .map((doc) => UserModel.fromDocument(doc));
  }
}
