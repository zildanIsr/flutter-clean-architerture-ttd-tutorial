import 'dart:convert';

import 'package:flutter_application_2/core/utils/typedef.dart';
import 'package:flutter_application_2/src/authentication/data/models/user_model.dart';
import 'package:flutter_application_2/src/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  final tJson = fixtures('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  test('Should be a subclass of [User] entity', () {
    //Assert
    expect(tModel, isA<User>());
  });

  group('from Map testing', () {
    test('should return a [UserModel] with the right data', () {
      //Act
      final result = UserModel.fromMap(tMap);

      expect(result, equals(tModel));
    });
  });

  group('form JSON testing', () {
    test('should return a [MAP] with the right data', () {
      //Act
      final result = UserModel.fromJson(tJson);

      expect(result, equals(tModel));
    });
  });

  group('to Map', () {
    test('should return a [UserModel] with the right data', () {
      //Act
      final result = tModel.toMap();
      //Assert
      expect(result, equals(tMap));
    });
  });

  group('to JSON', () {
    test('should return a [JSON] string with the right data', () {
      //Act
      final result = tModel.toJson();

      final tjson = jsonEncode({
        "id": 1,
        "name": "_empty.name",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt"
      });
      //Assert
      expect(result, equals(tjson));
    });
  });

  group('copyWith', () {
    test('should return a new data', () {
      //Act
      final result = tModel.copyWith(name: 'zildan');
      //Assert
      expect(result.name, equals('zildan'));
    });
  });
}
