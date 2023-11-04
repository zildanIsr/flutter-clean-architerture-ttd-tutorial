import 'package:dartz/dartz.dart';
import 'package:flutter_application_2/src/authentication/domain/entities/user.dart';
import 'package:flutter_application_2/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_application_2/src/authentication/domain/usecases/get_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late GetUsers useCase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    useCase = GetUsers(repository);
  });

  const response = [User.empty()];

  test('should call the [AuthRepo.getUser and return List<Users>]', () async {
    //Arrange
    //STUB
    when(
      () => repository.getUser(),
    ).thenAnswer((_) async => const Right(response));

    //Act
    final result = await useCase();

    //Assert
    expect(result, equals(const Right<dynamic, List<User>>(response)));

    verify(() => repository.getUser()).called(1);

    verifyNoMoreInteractions(repository);
  });
}
