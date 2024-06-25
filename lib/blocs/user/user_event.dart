// lib/blocs/user/user_event.dart

part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UserEvent {}

class AddUser extends UserEvent {
  final UserModel user;

  const AddUser(this.user);

  @override
  List<Object> get props => [user];
}

class UsersUpdated extends UserEvent {
  final List<UserModel> users;

  const UsersUpdated(this.users);

  @override
  List<Object> get props => [users];
}
