import 'dart:convert';

import 'package:flutter_application_2/core/errors/exception.dart';
import 'package:flutter_application_2/core/utils/constants.dart';
import 'package:flutter_application_2/core/utils/typedef.dart';
import 'package:flutter_application_2/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  Future<List<UserModel>> getUser();
}

const kCreateUserEndpoint = '/users';
const kGetEndpoint = '/users';

class AuthRemoteScImpl implements AuthRemoteDataSource {
  const AuthRemoteScImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final response = await _client.post(
          Uri.parse('$kBaseURL$kCreateUserEndpoint'),
          body: jsonEncode(
              {'createdAt': createdAt, 'name': name, 'avatar': avatar}),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUser() async {
    try {
      final response = await _client.get(Uri.parse('$kBaseURL$kGetEndpoint'));

      //debugPrint(response.body);

      if (response.statusCode != 200) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }

      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((e) => UserModel.fromMap(e))
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
