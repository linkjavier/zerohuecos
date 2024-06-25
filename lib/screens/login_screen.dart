import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../blocs/auth/auth_bloc.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  AnimationConfiguration.synchronized(
                    duration: Duration(milliseconds: 3000),
                    child: FadeInAnimation(
                      child: Text("Iniciar Sesión",
                          style: TextStyle(color: Colors.white, fontSize: 40)),
                    ),
                  ),
                  SizedBox(height: 10),
                  AnimationConfiguration.synchronized(
                    duration: Duration(milliseconds: 1300),
                    child: FadeInAnimation(
                      child: Text("Bienvenido",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
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
                        AnimationConfiguration.synchronized(
                          duration: const Duration(milliseconds: 1400),
                          child: FadeInAnimation(
                            child: Container(
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
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
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
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        const AnimationConfiguration.synchronized(
                          duration: Duration(milliseconds: 1500),
                          child: FadeInAnimation(
                            child: Text("¿Olvidaste tu contraseña?",
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        const SizedBox(height: 40),
                        AnimationConfiguration.synchronized(
                          duration: const Duration(milliseconds: 1600),
                          child: FadeInAnimation(
                            child: MaterialButton(
                              onPressed: () {
                                final email = _emailController.text;
                                final password = _passwordController.text;
                                context.read<AuthBloc>().add(
                                    AuthSignInRequested(
                                        email: email, password: password));
                              },
                              height: 50,
                              color: Colors.orange[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Center(
                                child: Text("Iniciar",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        const AnimationConfiguration.synchronized(
                          duration: Duration(milliseconds: 1700),
                          child: FadeInAnimation(
                            child: Text("Continuar con redes sociales",
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: AnimationConfiguration.synchronized(
                                duration: const Duration(milliseconds: 1800),
                                child: FadeInAnimation(
                                  child: MaterialButton(
                                    onPressed: () {},
                                    height: 50,
                                    color: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Center(
                                      child: Text("Facebook",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              child: AnimationConfiguration.synchronized(
                                duration: const Duration(milliseconds: 1900),
                                child: FadeInAnimation(
                                  child: MaterialButton(
                                    onPressed: () {},
                                    height: 50,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    color: Colors.black,
                                    child: const Center(
                                      child: Text("Github",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthError) {
                              return Text(state.message,
                                  style: const TextStyle(color: Colors.red));
                            }
                            return Container();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: const Text('CREAR CUENTA'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
