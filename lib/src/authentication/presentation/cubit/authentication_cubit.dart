import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_2/src/authentication/domain/entities/user.dart';
import 'package:flutter_application_2/src/authentication/domain/usecases/create_user.dart';
import 'package:flutter_application_2/src/authentication/domain/usecases/get_user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(
      {required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthenticationInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUserHandler({
    required createdAt,
    required name,
    required avatar,
  }) async {
    emit(const CreatingUser());

    final result = await _createUser(
        CreateUserParams(createdAt: createdAt, name: name, avatar: avatar));

    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
        (_) => emit(const UserCreated()));
  }

  Future<void> getUserHandler() async {
    emit(const GettingUser());

    final result = await _getUsers();

    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
        (users) => emit(UserLoaded(users)));
  }
}
