// lib/widgets/pothole_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/pothole/pothole_bloc.dart';
import '../models/pothole.dart'; // Importa el modelo de Pothole si es necesario

class PotholeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PotholeBloc, PotholeState>(
      builder: (context, state) {
        if (state is PotholeLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PotholeLoaded) {
          final potholes = state.potholes;
          return ListView.builder(
            itemCount: potholes.length,
            itemBuilder: (context, index) {
              final pothole = potholes[index];
              return ListTile(
                title: Text(pothole.name), // Suponiendo que el modelo tiene un atributo 'name'
                subtitle: Text(pothole.timestamp.toString()), // Suponiendo que el modelo tiene un atributo 'timestamp'
              );
            },
          );
        } else {
          return Center(child: Text('Something went wrong!'));
        }
      },
    );
  }
}

