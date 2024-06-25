import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final DateTime birthDate;
  final String? profilePictureUrl;
  final DateTime registrationDate;
  final int ranking;
  final String role;
  final String? location;
  final int potholesReportedCount;
  final bool isVerified;
  final String? bio;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.birthDate,
    this.profilePictureUrl,
    required this.registrationDate,
    this.ranking = 0,
    this.role = 'user',
    this.location,
    this.potholesReportedCount = 0,
    this.isVerified = false,
    this.bio,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      phoneNumber: data['phoneNumber'],
      birthDate: (data['birthDate'] as Timestamp).toDate(),
      profilePictureUrl: data['profilePictureUrl'],
      registrationDate: (data['registrationDate'] as Timestamp).toDate(),
      ranking: data['ranking'],
      role: data['role'],
      location: data['location'],
      potholesReportedCount: data['potholesReportedCount'],
      isVerified: data['isVerified'],
      bio: data['bio'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'birthDate': Timestamp.fromDate(birthDate),
      'profilePictureUrl': profilePictureUrl,
      'registrationDate': Timestamp.fromDate(registrationDate),
      'ranking': ranking,
      'role': role,
      'location': location,
      'potholesReportedCount': potholesReportedCount,
      'isVerified': isVerified,
      'bio': bio,
    };
  }
}
