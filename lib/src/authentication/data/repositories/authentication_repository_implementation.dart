import 'package:dartz/dartz.dart';
import 'package:flutter_application_2/core/errors/exception.dart';
import 'package:flutter_application_2/core/errors/failure.dart';
import 'package:flutter_application_2/core/utils/typedef.dart';
import 'package:flutter_application_2/src/authentication/data/sources/network/auth_remote_data_source.dart';
import 'package:flutter_application_2/src/authentication/domain/entities/user.dart';
import 'package:flutter_application_2/src/authentication/domain/repositories/authentication_repository.dart';

class AuthRepositoryImplementation implements AuthenticationRepository {
  AuthRepositoryImplementation(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUser() async {
    try {
      final result = await _remoteDataSource.getUser();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
