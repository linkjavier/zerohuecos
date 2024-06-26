import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../blocs/pothole/pothole_bloc.dart';
import '../models/pothole.dart';

class AddPotholeScreen extends StatefulWidget {
  const AddPotholeScreen({super.key});

  @override
  _AddPotholeScreenState createState() => _AddPotholeScreenState();
}

class _AddPotholeScreenState extends State<AddPotholeScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _city = '';
  String _state = '';
  String _street = '';
  String _streetNumber = '';
  String _postalCode = '';
  String _neighborhood = '';
  bool _isLoadingLocation = true;
  bool _isDisposed = false;
  final List<File> _photos = [];
  final List<File> _videos = [];
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _determinePosition().then((position) {
      if (_isDisposed) return;
      if (position != null) {
        _getLocationDetails(position.latitude, position.longitude)
            .then((details) {
          if (_isDisposed) return;
          setState(() {
            _city = details['city']!;
            _state = details['state']!;
            _street = details['street']!;
            _streetNumber = details['streetNumber']!;
            _postalCode = details['postalCode']!;
            _neighborhood = details['neighborhood']!;
            _isLoadingLocation = false;
          });
        });
      } else {
        setState(() {
          _isLoadingLocation = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _nameController.dispose();
    super.dispose();
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!_isDisposed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Los servicios de ubicación están deshabilitados.')),
        );
      }
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!_isDisposed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Permiso de ubicación denegado.')),
          );
        }
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!_isDisposed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Permiso de ubicación denegado permanentemente.')),
        );
      }
      return null;
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<Map<String, String>> _getLocationDetails(
      double latitude, double longitude) async {
    Map<String, String> details = {
      'city': 'Ciudad desconocida',
      'state': 'Estado desconocido',
      'street': 'Calle desconocida',
      'streetNumber': 'Número de calle desconocido',
      'postalCode': 'Código postal desconocido',
      'neighborhood': 'Barrio desconocido',
    };

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        details['city'] = place.locality ?? 'Ciudad desconocida';
        details['state'] = place.administrativeArea ?? 'Estado desconocido';
        details['street'] = place.street ?? 'Calle desconocida';
        details['streetNumber'] =
            place.subThoroughfare ?? 'Número de calle desconocido';
        details['postalCode'] = place.postalCode ?? 'Código postal desconocido';
        details['neighborhood'] = place.subLocality ?? 'Barrio desconocido';
      }
    } catch (e) {
      print('Error al obtener los detalles de la ubicación: $e');
    }

    return details;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
    status = await Permission.photos.status;
    if (!status.isGranted) {
      await Permission.photos.request();
    }

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _photos.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _pickVideo() async {
    final picker = ImagePicker();

    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
    status = await Permission.photos.status;
    if (!status.isGranted) {
      await Permission.photos.request();
    }

    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videos.add(File(pickedFile.path));
      });
    }
  }

  Future<List<String>> _uploadFiles(List<File> files, String folder) async {
    List<String> downloadUrls = [];
    for (var file in files) {
      String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
      Reference storageReference =
          FirebaseStorage.instance.ref().child('$folder/$fileName');
      UploadTask uploadTask = storageReference.putFile(file);
      uploadTask.snapshotEvents.listen((event) {
        setState(() {
          _uploadProgress =
              event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
        });
      });
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Bache'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const SizedBox(height: 20),
              _isLoadingLocation
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ciudad: $_city',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Estado: $_state',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Calle: $_street',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Número de Calle: $_streetNumber',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Código Postal: $_postalCode',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Barrio: $_neighborhood',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Seleccionar Foto'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickVideo,
                child: const Text('Seleccionar Video'),
              ),
              const SizedBox(height: 20),
              if (_photos.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fotos seleccionadas:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _photos
                          .map((photo) =>
                              Image.file(photo, height: 100, width: 100))
                          .toList(),
                    ),
                  ],
                ),
              if (_videos.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Videos seleccionados:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _videos
                          .map((video) => Icon(Icons.video_file, size: 100))
                          .toList(),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              if (_isUploading) LinearProgressIndicator(value: _uploadProgress),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isUploading = true;
                  });
                  final name = _nameController.text;
                  final position = await _determinePosition();

                  if (position != null) {
                    final photoUrls = await _uploadFiles(_photos, 'photos');
                    final videoUrls = await _uploadFiles(_videos, 'videos');

                    final pothole = Pothole(
                      id: '',
                      name: name,
                      timestamp: DateTime.now(),
                      location: GeoPoint(position.latitude, position.longitude),
                      city: _city,
                      state: _state,
                      street: _street,
                      streetNumber: _streetNumber,
                      postalCode: _postalCode,
                      neighborhood: _neighborhood,
                      photoUrls: photoUrls,
                      videoUrls: videoUrls,
                    );
                    context.read<PotholeBloc>().add(AddPothole(pothole));
                    Navigator.pop(context);
                  }
                  setState(() {
                    _isUploading = false;
                  });
                },
                child: const Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
