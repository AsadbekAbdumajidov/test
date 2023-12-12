import 'package:dartz/dartz.dart';
import 'package:test/core/error/error.dart';
import 'package:test/core/usecase/usecase.dart';
import 'package:test/data/domain/repository/main.dart';
import 'package:test/data/model/users_response/users_response.dart';

class UsersUseCase
    extends UseCase<List<UsersResponse>, NoParams> {
  final IMainRepository _mainRepository;
  UsersUseCase(this._mainRepository);

  @override
  Future<Either<Failure, List<UsersResponse>>> call(NoParams params) =>
      _mainRepository.getUsers();
}
