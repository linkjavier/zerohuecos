// lib/blocs/map/map_event.dart
import 'package:equatable/equatable.dart';
import '../../models/pothole.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class LocatePothole extends MapEvent {
  final Pothole pothole;

  const LocatePothole(this.pothole);

  @override
  List<Object> get props => [pothole];
}
