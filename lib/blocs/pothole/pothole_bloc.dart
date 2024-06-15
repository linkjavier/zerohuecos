// lib/blocs/pothole/pothole_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/pothole.dart';
import '../../repositories/pothole_repository.dart';

part 'pothole_event.dart';
part 'pothole_state.dart';

class PotholeBloc extends Bloc<PotholeEvent, PotholeState> {
  final PotholeRepository _potholeRepository;

  PotholeBloc({required PotholeRepository potholeRepository})
      : _potholeRepository = potholeRepository,
        super(PotholeLoading()) {
    on<LoadPotholes>(_onLoadPotholes);
    on<AddPothole>(_onAddPothole);
  }

  void _onLoadPotholes(LoadPotholes event, Emitter<PotholeState> emit) {
    _potholeRepository.getPotholes().listen((potholes) {
      add(PotholesUpdated(potholes));
    });
  }

  void _onAddPothole(AddPothole event, Emitter<PotholeState> emit) async {
    await _potholeRepository.addPothole(event.pothole);
  }
}
