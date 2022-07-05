import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_clinic/services/backend.dart';

class Api {
  final Dio api = Dio();
  String? accessToken;
  final baseUrl = 'https://base.maado.me/api/v1';
  final _storage = const FlutterSecureStorage();
  Api() {
    print('class Runing');

    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      print('optionsHeaders => ${options.headers}');
      if (!options.path.contains('https')) {
        print('optionsHeaders => ${options.headers}');

        options.path = baseUrl + options.path;
        print('optionsHeaders => ${options.headers}');
      }
      accessToken = await Backend.getToken('token');
      options.headers['Content-Type'] = 'application/json; charset=UTF-8';
      options.headers['Accept'] = 'application/json';
      options.headers['Authorization'] = 'Bearer $accessToken';
      print('optionsHeader to see if it working => ${options.headers}');

      return handler.next(options);
    }, onError: (DioError error, handler) async {
      if ((error.response?.statusCode == 401 &&
          error.response?.data['error']['message'] ==
              "Invalid refresh token")) {
        if (await _storage.containsKey(key: 'refresh_token')) {
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

    final refreshToken = await _storage.read(key: 'refresh_token');
    final response = await api
        .post('$baseUrl/auth/refresh', data: {'refresh_token': refreshToken});

    if (response.statusCode == 201) {
      print('response.data ${response.data}');
      print('old accessToken $accessToken');
      accessToken = response.data.token;
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
