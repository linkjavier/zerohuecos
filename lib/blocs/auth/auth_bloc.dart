// lib/blocs/auth/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AuthUserChanged>(_onAuthUserChanged);
    on<AuthSignOutRequested>(_onSignOutRequested);
    on<AuthSignInRequested>(
        _onSignInRequested); // Añadir el manejador del evento
  }

  void _onAuthUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    emit(event.user != null
        ? Authenticated(user: event.user!)
        : Unauthenticated());
  }

  void _onSignOutRequested(
      AuthSignOutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
  }

  void _onSignInRequested(
      AuthSignInRequested event, Emitter<AuthState> emit) async {
    try {
      await _authRepository.signInWithEmailAndPassword(
          event.email, event.password);
    } catch (_) {
      emit(AuthError('Failed to sign in'));
    }
  }
}
