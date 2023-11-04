import 'package:equatable/equatable.dart';
import 'package:flutter_application_2/core/usecase/usecase.dart';
import 'package:flutter_application_2/core/utils/typedef.dart';
import 'package:flutter_application_2/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  final AuthenticationRepository _authRepository;

  const CreateUser(this._authRepository);

  @override
  ResultVoid call(CreateUserParams params) async =>
      await _authRepository.createUser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avatar);
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams.empty()
      : this(
            createdAt: '_empty.String',
            name: '_empty.String',
            avatar: '_empty.String');

  const CreateUserParams(
      {required this.createdAt, required this.name, required this.avatar});

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
