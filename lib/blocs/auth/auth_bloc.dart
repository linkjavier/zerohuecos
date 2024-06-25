// lib/blocs/auth/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth_repository.dart';
import 'package:zerohuecos/repositories/user_repository.dart';
import 'package:zerohuecos/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  String? _currentUserId;

  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
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
    if (event.user != null) {
      _currentUserId = event.user!.uid;
      emit(Authenticated(user: event.user!));
    } else {
      emit(Unauthenticated());
    }
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
      emit(const AuthError('Failed to sign in'));
    }
  }

  void _onSignUpRequested(
      AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.signUpWithEmailAndPassword(
          event.email, event.password);
      await _userRepository.createUser(UserModel(
        id: user!.uid,
        email: user.email!,
        firstName: '',
        lastName: '',
        phoneNumber: '',
        birthDate: DateTime(2000, 1, 1), // Fecha de nacimiento predeterminada
        registrationDate: DateTime.now(),
        ranking: 0,
        role: 'user',
        location: '',
        potholesReportedCount: 0,
        isVerified: false,
        bio: '',
      ));
      emit(AuthSignUpSuccess(
          userId: user.uid,
          userEmail: user.email!)); // Emitir AuthSignUpSuccess con userId
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
