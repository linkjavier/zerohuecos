import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../models/user.dart';
import '../main.dart'; // Importa tu aplicación principal (MyApp)

class UserInfoScreen extends StatefulWidget {
  final String userId;
  const UserInfoScreen({required this.userId});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete your information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSignUpSuccess) {
              return Column(
                children: [
                  TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(labelText: "First Name"),
                  ),
                  TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(labelText: "Last Name"),
                  ),
                  TextField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(labelText: "Phone Number"),
                  ),
                  TextField(
                    controller: _birthDateController,
                    decoration: InputDecoration(labelText: "Birth Date"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final user = UserModel(
                        id: state.userId,
                        email: state.userEmail,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        phoneNumber: _phoneNumberController.text,
                        birthDate: DateTime.parse(_birthDateController.text),
                      );
                      context.read<UserBloc>().add(AddUser(user));
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                        (route) => false, // Elimina todas las rutas anteriores
                      );
                    },
                    child: Text("Submit"),
                  )
                ],
              );
            } else {
              return Center(
                child: Text(widget.userId),
              );
            }
          },
        ),
      ),
    );
  }
}
