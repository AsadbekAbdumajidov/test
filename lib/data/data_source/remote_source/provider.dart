import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:test/core/constants/constants.dart';
import 'package:test/data/model/users_response/users_response.dart';
part 'provider.g.dart';

//flutter packages pub run build_runner build --delete-conflicting-outputs

@RestApi(baseUrl: BASE_URL)
abstract class ApiClient {
  factory ApiClient(Dio dio, String baseUrl) {
    dio.options = BaseOptions(receiveTimeout: 3000, connectTimeout: 3000);
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @GET('afeb92ab139c431f8f7bb3eb0660b8c9/users')
  Future<List<UsersResponse>> getUsers();
}
