// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/pothole/pothole_bloc.dart';
import 'repositories/auth_repository.dart';
import 'repositories/pothole_repository.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_pothole_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository: AuthRepository()),
        ),
        BlocProvider(
          create: (context) =>
              PotholeBloc(potholeRepository: PotholeRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'ZeroHuecos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return HomeScreen();
                } else {
                  return LoginScreen();
                }
              },
            );
          },
          '/add_pothole': (context) => AddPotholeScreen(),
        },
      ),
    );
  }
}
