import 'package:equatable/equatable.dart';
import 'package:flutter_application_2/core/errors/exception.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  String get errorMessage => '$statusCode, Error: $message';

  @override
  List<Object> get props => [message, statusCode];
}

class APIFailure extends Failure {
  const APIFailure({required super.message, required super.statusCode});

  factory APIFailure.fromException(APIException exception) =>
      APIFailure(message: exception.message, statusCode: exception.statusCode);
}
