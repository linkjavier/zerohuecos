// lib/blocs/map/map_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<LocatePothole>(_onLocatePothole);
  }

  void _onLocatePothole(LocatePothole event, Emitter<MapState> emit) {
    // Aquí establecemos un nivel de zoom máximo, por ejemplo, 20.0
    emit(MapPotholeLocated(event.pothole, 20.0));
  }
}
