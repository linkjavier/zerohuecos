import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/pothole.dart';

class PotholeDetailsScreen extends StatelessWidget {
  final Pothole pothole;

  const PotholeDetailsScreen({super.key, required this.pothole});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pothole.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: ${pothole.name}',
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text('Fecha y Hora: ${pothole.timestamp}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(
                  'Ubicación: (${pothole.location.latitude}, ${pothole.location.longitude})',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Ciudad: ${pothole.city}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Estado: ${pothole.state}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Calle: ${pothole.street}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Número de Calle: ${pothole.streetNumber}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Código Postal: ${pothole.postalCode}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Barrio: ${pothole.neighborhood}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              const Text('Fotos:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              pothole.photoUrls.isEmpty
                  ? const Text('No hay fotos disponibles')
                  : Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: pothole.photoUrls
                          .map((url) =>
                              Image.network(url, height: 200, width: 200))
                          .toList(),
                    ),
              const SizedBox(height: 20),
              const Text('Videos:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              pothole.videoUrls.isEmpty
                  ? const Text('No hay videos disponibles')
                  : Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: pothole.videoUrls
                          .map((url) => AspectRatio(
                                aspectRatio: 16 / 9,
                                child: VideoPlayerScreen(url: url),
                              ))
                          .toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String url;

  const VideoPlayerScreen({super.key, required this.url});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
