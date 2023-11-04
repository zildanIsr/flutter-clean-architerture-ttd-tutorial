part of 'authentication_bloc.dart';

sealed class AuthentiocationState extends Equatable {
  const AuthentiocationState();

  @override
  List<Object> get props => [];
}

final class AuthentiocationInitial extends AuthentiocationState {}

class CreatingUser extends AuthentiocationState {
  const CreatingUser();
}

class GettingUser extends AuthentiocationState {
  const GettingUser();
}

class UserCreated extends AuthentiocationState {
  const UserCreated();
}

class UserLoaded extends AuthentiocationState {
  const UserLoaded(this.users);

  final List<User> users;

  @override
  List<Object> get props => users.map((e) => e.id).toList();
}

class AuthenticationError extends AuthentiocationState {
  const AuthenticationError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
