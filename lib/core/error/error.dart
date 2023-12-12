import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LocalizedMessage {
  String getLocalizedMessage(BuildContext context);
}

abstract class Failure extends Equatable implements LocalizedMessage {
  const Failure();

  @override
  List<Object> get props => [];
}

class EmptyFailure extends Failure {
  const EmptyFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) => '';
}
class ConnectionFailure extends Failure {
  const ConnectionFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) =>
     "Connaction failure";
}
class UnknownFailure extends Failure {
  const UnknownFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) => "Unknown failure";
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(this.statusCode) : super();

  @override
  List<Object> get props => [statusCode ?? 0];

  @override
  String getLocalizedMessage(BuildContext context) =>
      'Server error $statusCode';
}