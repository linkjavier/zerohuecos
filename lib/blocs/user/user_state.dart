// lib/blocs/user/user_state.dart

part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserModel> users;

  const UserLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}

class UserAddSuccess extends UserState {}

class UserAddFailure extends UserState {
  final String error;

  const UserAddFailure(this.error);

  @override
  List<Object> get props => [error];
}
