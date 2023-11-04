import 'package:flutter_application_2/core/usecase/usecase.dart';
import 'package:flutter_application_2/core/utils/typedef.dart';
import 'package:flutter_application_2/src/authentication/domain/entities/user.dart';
import 'package:flutter_application_2/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  final AuthenticationRepository _authRepository;

  const GetUsers(this._authRepository);

  @override
  ResultFuture<List<User>> call() async => await _authRepository.getUser();
}
