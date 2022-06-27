import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Api {
  final Dio api = Dio();
  String? accessToken;
  final baseUrl = 'https://base.maado.me/api/v1';
  final _storage = const FlutterSecureStorage();
  Api() {
    print('class Runing');

    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (!options.path.contains('https')) {
        options.path = baseUrl + options.path;
      }

      options.headers['Content-Type'] = 'application/json; charset=UTF-8';
      options.headers['Accept'] = 'application/json';
      options.headers['Authorization'] = 'Bearer $accessToken';

      return handler.next(options);
    }, onError: (DioError error, handler) async {
      if ((error.response?.statusCode == 401 &&
          error.response?.data['message'] == "Invalid JWT")) {
        if (await _storage.containsKey(key: 'refreshToken')) {
          if (await refreshToken()) {
            return handler.resolve(await _retry(error.requestOptions));
          }
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
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> refreshToken() async {
    print('refreshToken Runing');

    final refreshToken = await _storage.read(key: 'refreshToken');
    final response = await api
        .post('$baseUrl/auth/refresh', data: {'refreshToken': refreshToken});

    if (response.statusCode == 201) {
      print('response.data ${response.data}');
      print('old accessToken $accessToken');
      accessToken = response.data;
      print('new Refresh Token ${response.data}');

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
}
