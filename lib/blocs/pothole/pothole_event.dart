// lib/blocs/pothole/pothole_event.dart
part of 'pothole_bloc.dart';

abstract class PotholeEvent extends Equatable {
  const PotholeEvent();

  @override
  List<Object?> get props => [];
}

class LoadPotholes extends PotholeEvent {}

class AddPothole extends PotholeEvent {
  final Pothole pothole;

  const AddPothole(this.pothole);

  @override
  List<Object?> get props => [pothole];
}

class PotholesUpdated extends PotholeEvent {
  final List<Pothole> potholes;

  const PotholesUpdated(this.potholes);

  @override
  List<Object?> get props => [potholes];
}
