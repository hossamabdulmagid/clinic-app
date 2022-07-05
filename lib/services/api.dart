import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_clinic/services/backend.dart';

class Api {
  final Dio api = Dio();
  String? accessToken;
  final baseUrl = 'http://192.168.1.12/api/v1';
  final _storage = const FlutterSecureStorage();
  Api() {
    print('class Runing');

    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      print('optionsHeaders => ${options.headers}');
      if (!options.path.contains('http')) {
        print('optionsHeaders => ${options.headers}');

        options.path = baseUrl + options.path;
      }
      accessToken = await Backend.getToken('token');
      options.headers['Content-Type'] = 'application/json; charset=UTF-8';
      options.headers['Accept'] = 'application/json';
      options.headers['Authorization'] = 'Bearer $accessToken';
      print('optionsHeader to see if it working => ${options.headers}');

      return handler.next(options);
    }, onError: (DioError error, handler) async {
      print('@@@@@@@@@@@@@@@@@out of Condition @@@@@@@@@@@@@@');
      print(
          '@@ refresh Token  refresh Token  refresh Token  refresh Token  refresh Token   @@');
      print(error.response);

      if ((error.response?.statusCode == 401 &&
          error.response?.data['error']['message'] ==
              "Invalid / expired access token")) {
        print('@@@@@@@@@@@@@@@@@@from if condtion @@@@@@@@@@@@@');
        print(
            '@@ refresh Token  LAL ALALLAA Token  refresh Token  refresh Token  refresh Token   @@');
        print(error.response);

        var re = await Backend.getToken('refresh_token');
        print('re@@ = > $re');
        print(
            '${await Backend.storage.containsKey(key: 'refresh_token')} await Backend.storage.containsKey(key: '
            ')');
        if (re != null) {
          print(
              '@@ refresh Token  refresh Token  refresh Token  refresh Token  refresh Token   @@');
          if (await refreshToken()) {
            print(' ree != null');

            print(
                '@@await refreshToken()await refreshToken()await refreshToken()await refreshToken()  await await await await refresh Token  refresh Token  refresh Token  refresh Token   @@');
            return handler.resolve(await _retry(error.requestOptions));
          }
        } else {
          print('its not running from first');
          print(' ree == null');
        }
      }
      return handler.next(error);
    }));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    print('_retry Runing');

    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    print(options.headers);
    print(options.headers);
    print(options.headers);
    print(options.headers);

    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> refreshToken() async {
    print('refreshToken Runing');

    final refreshToken = await Backend.getToken('refresh_token');
    final response = await api
        .post('$baseUrl/auth/refresh', data: {'refresh_token': refreshToken});

    print('response with new token is Coming here $response');

    // print(response.data.token.toString());

    if (response.statusCode == 200) {
      print('response.with new token ${response.data['data']['token']}');
      print('old accessToken $accessToken');
      print(' access token before null from $accessToken');

      accessToken = null;
      print(' access token after null from $accessToken');

      await Backend.deleteToken('token');
      await Backend.deleteToken('refresh_token');

      await Backend.storeToken('token', response.data['data']['token']);
      await Backend.storeRefreshToken(
          'token', response.data['data']['refresh_token']);

      accessToken = response.data['data']['token'];
      print('new access token from $accessToken');

      print('new Refresh Token ${response.data['data']['refresh_token']}');
      print('new Token ${response.data['data']['token']}');

      return true;
    } else {
      // refresh token is wrong
      print('null accessToken $accessToken');

      accessToken = null;
      print('null accessToken $accessToken');
      _storage.deleteAll();
      return false;
    }
  }
  //   Future<dynamic> get(String url) async {
  //   try {
  //     final response = await dio.get(url);
  //     var apiResponse = ApiResponse.fromJson(response.data);
  //     if (apiResponse.status != 200) {
  //       throw Exception(apiResponse.message);
  //     }
  //     return apiResponse.data;
  //   } on DioError catch (e) {
  //     // debugging purpose
  //     print('[Dio Helper - GET] Connection Exception => ' + e.message);
  //     throw e;
  //   }
  // }

  // Future<dynamic> post(String url,
  //     {Map headers, @required data, encoding}) async {
  //   try {
  //     final response =
  //         await dio.post(url, data: data, options: Options(headers: headers));
  //     ApiResponse apiResponse = ApiResponse.fromJson(response.data);
  //     if (apiResponse.status != 200) {
  //       throw Exception(apiResponse.message);
  //     }
  //     return apiResponse.data;
  //   } on DioError catch (e) {
  //     // debugging purpose
  //     print('[Dio Helper - GET] Connection Exception => ' + e.message);
  //     throw e;
  //   }
  // }
}
