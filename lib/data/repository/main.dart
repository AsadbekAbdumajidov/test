
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:test/core/error/error.dart';
import 'package:test/data/data_source/remote_source/provider.dart';
import 'package:test/data/domain/repository/main.dart';
import 'package:test/data/model/users_response/users_response.dart';

class MainRepository extends IMainRepository {
  final ApiClient _apiClient;

  MainRepository(this._apiClient);

  @override
  Future<Either<Failure, List<UsersResponse>>> getUsers() async{
    try {
      final response = await _apiClient.getUsers();
      return Right(response);
    } on DioError catch (e) {
      if (kDebugMode) {
        debugPrint("$e");
      }
      if (e.error is SocketException) {
        return const Left(ConnectionFailure());
      }
      return Left(
        (e.response?.statusCode == 404)
            ? const UnknownFailure()
            : ServerFailure(e.response?.statusCode),
      );
    } on Object catch (e) {
      if (kDebugMode) {
        debugPrint("$e");
      }
      rethrow;
    }
  }

 

 }
