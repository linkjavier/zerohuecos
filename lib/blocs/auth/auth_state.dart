// lib/blocs/auth/auth_state.dart
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  const Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthSignUpSuccess extends AuthState {
  final String userId; // Campo para almacenar el userId
  final String userEmail; // Campo para almacenar el Email

  const AuthSignUpSuccess({required this.userId, required this.userEmail});

  @override
  List<Object?> get props => [userId];
}
