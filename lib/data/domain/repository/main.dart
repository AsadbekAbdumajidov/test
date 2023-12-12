import 'package:dartz/dartz.dart';
import 'package:test/core/error/error.dart';
import 'package:test/data/model/users_response/users_response.dart';

abstract class IMainRepository {
  Future<Either<Failure, List<UsersResponse>>> getUsers();

}
