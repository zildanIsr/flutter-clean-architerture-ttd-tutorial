import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String createdAt;
  final String name;
  final String avatar;

  const User(this.id, this.createdAt, this.name, this.avatar);

  @override
  List<Object?> get props => [id];
}
