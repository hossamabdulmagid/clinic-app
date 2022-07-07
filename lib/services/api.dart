import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_clinic/services/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final Dio api = Dio();
  String? accessToken;
  final baseUrl = 'http://192.168.1.12/api/v1';
  final baseUrlProduction = 'https://base.maado.me/api/v1';

  Api() {
    api.interceptors.clear();
    api.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        accessToken = await Backend.getToken('token');

        if (accessToken != null && accessToken != "") {
          options.headers['Content-Type'] = 'application/json; charset=UTF-8';
          options.headers['Accept'] = 'application/json';
          options.headers['Authorization'] = 'Bearer $accessToken';
        }

        return handler.next(options);
      },
      onError: (DioError error, handler) async {
        if ((error.response?.statusCode == 401 &&
            error.response?.data['error']['message'] ==
                "Invalid / expired access token")) {
          print('now runing from error 401');
          try {
            var refreshtoken = await Backend.getRefreshToken('refresh_token');
            var token;

            await api
                .post("$baseUrlProduction/auth/refresh",
                    data: jsonEncode({"refresh_token": refreshtoken}))
                .then((value) async {
              if (value.statusCode == 200) {
                //get new tokens ...
                print(
                    'refreshToken Get @@ ${value.data['data']['token']}  Called');
                accessToken = value.data['data']['token'];
                refreshtoken = value.data['data']['refresh_token'];
                //set bearer
                if (value.data['data']['token'] == accessToken) {
                  await Backend.deleteToken();

                  await Backend.storeToken(
                      'token', value.data['data']['token']);
                  await Backend.storeRefreshToken(
                      'refresh_token', value.data['data']['refresh_token']);
                }

                error.requestOptions.headers["Authorization"] =
                    "Bearer $accessToken";

                //create request with new access token
                final opts = Options(
                    method: error.requestOptions.method,
                    headers: error.requestOptions.headers);
                final cloneReq = await api.request(error.requestOptions.path,
                    options: opts,
                    data: error.requestOptions.data,
                    queryParameters: error.requestOptions.queryParameters);

                return handler.resolve(cloneReq);
              }
              return handler.next(error);
            });
          } catch (e) {
            print('error massage :$e');
          }
        }
        return handler.next(error);
      },
      onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response);

        // continue
      },
    ));
  }
}
