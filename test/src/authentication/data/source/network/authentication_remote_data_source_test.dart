import 'dart:convert';

import 'package:flutter_application_2/core/errors/exception.dart';
import 'package:flutter_application_2/core/utils/constants.dart';
import 'package:flutter_application_2/src/authentication/data/models/user_model.dart';
import 'package:flutter_application_2/src/authentication/data/sources/network/auth_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteScImpl(client);
    registerFallbackValue(Uri());
  });

  group('create user', () {
    test('should complete successfully when the status code is 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201));

      final methodCall = remoteDataSource.createUser;

      // Panggil createUser dengan parameter yang sesuai
      await methodCall(createdAt: 'createdAt', name: 'name', avatar: 'avatar');

      // Verifikasi bahwa client.post telah terjadi dengan benar
      verify(
        () => client.post(
          Uri.parse('$kBaseURL$kCreateUserEndpoint'),
          body: jsonEncode(
              {'createdAt': 'createdAt', 'name': 'name', 'avatar': 'avatar'}),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when the status code is not 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('Invalid email address', 400));

      final methodCall = remoteDataSource.createUser;

      expect(
          () async => methodCall(
              createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
          throwsA(const APIException(
              message: 'Invalid email address', statusCode: 400)));

      verify(
        () => client.post(
          Uri.parse('$kBaseURL$kCreateUserEndpoint'),
          body: jsonEncode(
              {'createdAt': 'createdAt', 'name': 'name', 'avatar': 'avatar'}),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('Get Users', () {
    const tUsers = [UserModel.empty()];
    test('should return [List<User>] when the status code is 200', () async {
      when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200));

      final result = await remoteDataSource.getUser();

      expect(result, equals(tUsers));

      verify(
        () => client.get(
          Uri.parse('$kBaseURL$kGetEndpoint'),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when the status code is not 200',
        () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('Server Down', 500));

      final methodCall = remoteDataSource.getUser;

      expect(() => methodCall(),
          throwsA(const APIException(message: 'Server Down', statusCode: 500)));

      verify(
        () => client.get(
          Uri.parse('$kBaseURL$kGetEndpoint'),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
