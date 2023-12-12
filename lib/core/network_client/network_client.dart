import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test/core/constants/constants.dart';

class NetworkClient {
  late final Dio api;

  Future<Dio> init() async {
    api = Dio();

    api.interceptors.add(InterceptorsWrapper(
      /// onRequest
      onRequest: (options, handler) async {
        options.headers['Authorization'] = "";
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },

      /// onError
      onError: (error, handler) async {
        if (_shouldRetry(error)) {
          try {
            //  DioConnectivityRequestRetrier(
            //         dio: api, connectivity: Connectivity())
            //     .scheduleRequestRetry(error.requestOptions);
          } catch (er) {
            return handler.next(error);
          }
        }

        if (error.response?.statusCode == 401) {
          // await refreshToken(preferences);
          RequestOptions requestOptions = error.requestOptions;
          final options = Options(
            method: requestOptions.method,
            headers: requestOptions.headers,
          );
          options.headers!['Authorization'] = "";
          Response cloneReq = await Dio().request<dynamic>(
            BASE_URL + requestOptions.path,
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
            options: options,
          );
          return handler.resolve(cloneReq);
        }
        return handler.next(error);
      },
    ));
    api.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return api;
  }

  // Future<void> refreshToken(SharedPreferences preferences) async {
  //   String refreshToken = preferences.getString(REFRESH_TOKEN) ?? '';
  //   Dio dio = Dio();
  //   try {
  //     debugPrint('AA: $refreshToken');
  //     final response = await dio
  //         .post('${BASE_URL}token/refresh/', data: {'refresh': refreshToken});
  //     if (response.statusCode == 200) {
  //       RefreshTokenResponse token =
  //           RefreshTokenResponse.fromJson(response.data);
  //       debugPrint('TTTTT: ${token.access}');
  //       await preferences.setString(ACCESS_TOKEN, token.access ?? "");
  //       await preferences.setString(REFRESH_TOKEN, token.refresh);
  //       _token = token.access ?? "";
  //     }
  //   } catch (err) {
  //     // _goToLoginScreen();
  //     debugPrint('EEE:$err');
  //   }
  // }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }

  // void _goToLoginScreen() async {
  //   await inject<AuthCubit>().logout();

  //   /// Navigate to Sign in Screen
  //   Navigator.of(AppKeys.navState.currentContext!).pushNamedAndRemoveUntil(
  //       AppRoutes.createProfile, (Route<dynamic> route) => false);
  // }
}
