import 'package:dartz/dartz.dart';
import 'package:flutter_application_2/core/errors/exception.dart';
import 'package:flutter_application_2/core/errors/failure.dart';
import 'package:flutter_application_2/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:flutter_application_2/src/authentication/data/sources/network/auth_remote_data_source.dart';
import 'package:flutter_application_2/src/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSc extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource remoteDataSc;
  late AuthRepositoryImplementation repositoryImp;

  setUp(() {
    remoteDataSc = MockAuthRemoteDataSc();
    repositoryImp = AuthRepositoryImplementation(remoteDataSc);
  });

  const createdAt = 'string.createdAt';
  const name = 'string.name';
  const avatar = 'string.avatar';

  const tException =
      APIException(message: 'Unknown Error Occurred', statusCode: 500);
  group('Create User', () {
    test(
        'should call the [RemoteDataSource.createUser] and complete successfully when the remote source is succesful',
        () async {
      //arrange
      when(() => remoteDataSc.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          )).thenAnswer((_) async => Future.value());

      //act

      final result = await repositoryImp.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      //assert
      expect(result, equals(const Right(null)));
      verify(() => remoteDataSc.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSc);
    });

    test(
        'should return a [APIFailur] when the call to the remote source is unseccessful',
        () async {
      //Arrange
      when(() => remoteDataSc.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          )).thenThrow(tException);

      //Act
      final result = await repositoryImp.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      //Assert
      expect(
          result,
          equals(Left(APIFailure(
              message: tException.message,
              statusCode: tException.statusCode))));

      verify(() => remoteDataSc.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);

      verifyNoMoreInteractions(remoteDataSc);
    });
  });

  group('Get User', () {
    test(
        'should call the [RemoteDataSource.getUser] and return List<User> when the remote source is succesful ',
        () async {
      when(() => remoteDataSc.getUser()).thenAnswer((_) async => []);

      final result = await repositoryImp.getUser();

      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => remoteDataSc.getUser()).called(1);
      verifyNoMoreInteractions(remoteDataSc);
    });

    test(
        'should return a [APIFailur] when the call to the remote source is unseccessful',
        () async {
      when(() => remoteDataSc.getUser()).thenThrow(tException);

      //Act
      final result = await repositoryImp.getUser();

      //Assert
      expect(
          result,
          equals(Left(APIFailure(
              message: tException.message,
              statusCode: tException.statusCode))));

      verify(() => remoteDataSc.getUser()).called(1);

      verifyNoMoreInteractions(remoteDataSc);
    });
  });
}
