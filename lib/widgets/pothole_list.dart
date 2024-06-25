import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zerohuecos/blocs/map/map_bloc.dart';
import 'package:zerohuecos/blocs/map/map_event.dart';
import '../blocs/pothole/pothole_bloc.dart';

class PotholeList extends StatefulWidget {
  const PotholeList({super.key});

  @override
  _PotholeListState createState() => _PotholeListState();
}

class _PotholeListState extends State<PotholeList> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PotholeBloc, PotholeState>(
      builder: (context, state) {
        if (state is PotholeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PotholeLoaded) {
          final potholes = state.potholes;
          return ListView.builder(
            itemCount: potholes.length,
            itemBuilder: (context, index) {
              final pothole = potholes[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = _selectedIndex == index ? -1 : index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pothole.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(pothole.timestamp.toString(),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                      ),
                      if (_selectedIndex == index) ...[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[900],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/pothole_details',
                              arguments: pothole,
                            );
                          },
                          child: const Text('Detalles'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[900],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            BlocProvider.of<MapBloc>(context)
                                .add(LocatePothole(pothole));
                          },
                          child: const Text('Locate'),
                        ),
                      ]
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('Something went wrong!'));
        }
      },
    );
  }
}
