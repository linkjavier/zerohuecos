// lib/blocs/user/user_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/user.dart';
import '../../repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<AddUser>(_onAddUser);
    on<UsersUpdated>(_onUsersUpdated);

    // Cargar los usuarios al iniciar el Bloc
    add(LoadUsers());
  }

  void _onLoadUsers(LoadUsers event, Emitter<UserState> emit) {
    _userRepository.getUsers().listen((users) {
      add(UsersUpdated(users));
    });
  }

  void _onAddUser(AddUser event, Emitter<UserState> emit) async {
    await _userRepository.createUser(event.user);
  }

  void _onUsersUpdated(UsersUpdated event, Emitter<UserState> emit) {
    emit(UserLoaded(users: event.users));
  }
}
