// lib/blocs/map/map_state.dart
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/pothole.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapPotholeLocated extends MapState {
  final Pothole pothole;
  final double zoom;

  const MapPotholeLocated(this.pothole, this.zoom);

  @override
  List<Object> get props => [pothole, zoom];
}
