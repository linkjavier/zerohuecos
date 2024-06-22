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
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);

    // Escuchar los cambios de usuario en FirebaseAuth
    _authRepository.user.listen((user) {
      add(AuthUserChanged(user));
    });
  }

  void _onAuthUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    emit(event.user != null
        ? Authenticated(user: event.user!)
        : Unauthenticated());
  }

  void _onSignOutRequested(
      AuthSignOutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
    emit(Unauthenticated());
  }

  void _onSignInRequested(
      AuthSignInRequested event, Emitter<AuthState> emit) async {
    try {
      await _authRepository.signInWithEmailAndPassword(
          event.email, event.password);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(AuthError('Failed to sign in'));
    }
  }

  void _onSignUpRequested(
      AuthSignUpRequested event, Emitter<AuthState> emit) async {
    try {
      await _authRepository.signUpWithEmailAndPassword(
          event.email, event.password);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(AuthError('Failed to sign up'));
    }
  }
}
