// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zerohuecos/blocs/user/user_bloc.dart';
import 'package:zerohuecos/models/pothole.dart';
import 'package:zerohuecos/repositories/user_repository.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/pothole/pothole_bloc.dart';
import 'blocs/map/map_bloc.dart';
import 'repositories/auth_repository.dart';
import 'repositories/pothole_repository.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_pothole_screen.dart';
import 'screens/pothole_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
              authRepository: AuthRepository(),
              userRepository: UserRepository()),
        ),
        BlocProvider(
          create: (context) =>
              PotholeBloc(potholeRepository: PotholeRepository()),
        ),
        BlocProvider(
          create: (context) => MapBloc(),
        ),
        BlocProvider(
            create: (context) => UserBloc(userRepository: UserRepository())),
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
                  return const HomeScreen();
                } else {
                  return const LoginScreen();
                }
              },
            );
          },
          '/add_pothole': (context) => const AddPotholeScreen(),
          '/pothole_details': (context) => PotholeDetailsScreen(
              pothole: ModalRoute.of(context)!.settings.arguments as Pothole),
        },
      ),
    );
  }
}
