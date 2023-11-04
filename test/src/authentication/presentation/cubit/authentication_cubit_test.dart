import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_2/core/errors/failure.dart';
import 'package:flutter_application_2/src/authentication/domain/usecases/create_user.dart';
import 'package:flutter_application_2/src/authentication/domain/usecases/get_user.dart';
import 'package:flutter_application_2/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tAPIFailure = APIFailure(message: 'message', statusCode: 404);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => cubit.close());

  test('initial state should be [AuthenticationInitial]', () async {
    expect(cubit.state, AuthenticationInitial());
  });

  group('Create User', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emits [CreatingUser, UserCreated] when MyEvent is added.',
        build: () {
          when(() => createUser(any()))
              .thenAnswer((_) async => const Right(null));

          return cubit;
        },
        act: (cubit) => cubit.createUserHandler(
            createdAt: tCreateUserParams.createdAt,
            name: tCreateUserParams.name,
            avatar: tCreateUserParams.avatar),
        expect: () => const [CreatingUser(), UserCreated()],
        verify: (_) {
          verify(() => createUser(tCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUser);
        });

    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emits [CreatingUser, AuthenticationError] when unsuccessfully.',
        build: () {
          when(() => createUser(any()))
              .thenAnswer((_) async => const Left(tAPIFailure));

          return cubit;
        },
        act: (cubit) => cubit.createUserHandler(
            createdAt: tCreateUserParams.createdAt,
            name: tCreateUserParams.name,
            avatar: tCreateUserParams.avatar),
        expect: () => [
              const CreatingUser(),
              AuthenticationError(tAPIFailure.errorMessage)
            ],
        verify: (_) {
          verify(() => createUser(tCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUser);
        });
  });

  group('Get User', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emits [GettingUsers, UsersLoaded] when successfully.',
        build: () {
          when(() => getUsers()).thenAnswer((_) async => const Right([]));

          return cubit;
        },
        act: (cubit) => cubit.getUserHandler(),
        expect: () => const [GettingUser(), UserLoaded([])],
        verify: (_) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });

    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emits [GettingUsers, AuthenticationError] when unsuccessfully.',
        build: () {
          when(() => getUsers())
              .thenAnswer((_) async => const Left(tAPIFailure));

          return cubit;
        },
        act: (cubit) => cubit.getUserHandler(),
        expect: () => [
              const GettingUser(),
              AuthenticationError(tAPIFailure.errorMessage)
            ],
        verify: (_) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });
  });
}
