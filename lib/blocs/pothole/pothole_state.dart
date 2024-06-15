// lib/blocs/pothole/pothole_state.dart
part of 'pothole_bloc.dart';

abstract class PotholeState extends Equatable {
  const PotholeState();

  @override
  List<Object?> get props => [];
}

class PotholeLoading extends PotholeState {}

class PotholeLoaded extends PotholeState {
  final List<Pothole> potholes;

  const PotholeLoaded({required this.potholes});

  @override
  List<Object?> get props => [potholes];
}

class PotholeError extends PotholeState {}
