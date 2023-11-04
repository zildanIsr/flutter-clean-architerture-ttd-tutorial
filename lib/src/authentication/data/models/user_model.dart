import 'dart:convert';

import 'package:flutter_application_2/core/utils/typedef.dart';
import 'package:flutter_application_2/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.createdAt,
      required super.name,
      required super.avatar});

  //User Model for testing class
  const UserModel.empty()
      : this(
            id: "1",
            createdAt: '_empty.createdAt',
            name: '_empty.name',
            avatar: '_empty.avatar');

  //Add new value to key
  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? avatar,
  }) {
    return UserModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar);
  }

  factory UserModel.fromMap(DataMap map) => UserModel(
      id: map['id'] as String,
      createdAt: map['createdAt'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String);

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json) as DataMap);

  DataMap toMap() =>
      {'id': id, 'name': name, 'avatar': avatar, 'createdAt': createdAt};

  String toJson() => jsonEncode(toMap());
}
