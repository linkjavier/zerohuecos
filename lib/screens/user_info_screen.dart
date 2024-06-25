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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete your information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserAddSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
                (route) => false, // Elimina todas las rutas anteriores
              );
            } else if (state is UserAddFailure) {
              // Mostrar un error si la adición del usuario falla
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Failed to add user: ${state.error}")),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSignUpSuccess) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(labelText: "First Name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(labelText: "Last Name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(labelText: "Phone Number"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _birthDateController,
                        decoration: InputDecoration(
                            labelText: "Birth Date (yyyy-mm-dd)"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your birth date';
                          }
                          try {
                            DateTime.parse(value);
                          } catch (_) {
                            return 'Please enter a valid date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final user = UserModel(
                              id: state.userId,
                              email: state.userEmail,
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              phoneNumber: _phoneNumberController.text,
                              birthDate:
                                  DateTime.parse(_birthDateController.text),
                              registrationDate: DateTime.now(),
                            );
                            context.read<UserBloc>().add(AddUser(user));
                          }
                        },
                        child: Text("Submit"),
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text("User ID: ${widget.userId}"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
