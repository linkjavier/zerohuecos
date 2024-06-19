// lib/widgets/pothole_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zerohuecos/blocs/map/map_bloc.dart';
import 'package:zerohuecos/blocs/map/map_event.dart';
import '../blocs/pothole/pothole_bloc.dart';
import '../models/pothole.dart';

class PotholeList extends StatefulWidget {
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
          return Center(child: CircularProgressIndicator());
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
                child: Column(
                  children: [
                    ListTile(
                      title: Text(pothole.name),
                      subtitle: Text(pothole.timestamp.toString()),
                    ),
                    if (_selectedIndex == index)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/pothole_details',
                                arguments: pothole,
                              );
                            },
                            child: Text('Detalles'),
                          ),
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<MapBloc>(context)
                                  .add(LocatePothole(pothole));
                            },
                            child: Text('Locate'),
                          ),
                        ],
                      )
                  ],
                ),
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
