import 'package:flutter_application_2/core/utils/typedef.dart';
import 'package:flutter_application_2/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  ResultFuture<List<User>> getUser();
}
