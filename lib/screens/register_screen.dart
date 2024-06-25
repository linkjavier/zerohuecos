import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import 'user_info_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Crear Cuenta",
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                  SizedBox(height: 10),
                  Text("Bienvenido",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 60),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200)),
                                  ),
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      hintText: "Correo Electrónico",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200)),
                                  ),
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      hintText: "Contraseña",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200)),
                                  ),
                                  child: TextField(
                                    controller: _confirmPasswordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      hintText: "Confirmar Contraseña",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          MaterialButton(
                            onPressed: () {
                              final email = _emailController.text;
                              final password = _passwordController.text;
                              final confirmPassword =
                                  _confirmPasswordController.text;

                              if (password == confirmPassword) {
                                context.read<AuthBloc>().add(
                                    AuthSignUpRequested(
                                        email: email, password: password));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Las contraseñas no coinciden')),
                                );
                              }
                            },
                            height: 50,
                            color: Colors.orange[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Text("Registrar",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(height: 50),
                          BlocListener<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthSignUpSuccess) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserInfoScreen(userId: state.userId)),
                                );
                              } else if (state is AuthError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              }
                            },
                            child: Container(),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
