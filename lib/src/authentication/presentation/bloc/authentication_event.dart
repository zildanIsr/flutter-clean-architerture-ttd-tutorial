part of 'authentication_bloc.dart';

sealed class AuthentiocationEvent extends Equatable {
  const AuthentiocationEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthentiocationEvent {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserEvent(
      {required this.createdAt, required this.name, required this.avatar});

  @override
  List<Object> get props => [createdAt, name, avatar];
}

class GetUserEvent extends AuthentiocationEvent {
  const GetUserEvent();
}
