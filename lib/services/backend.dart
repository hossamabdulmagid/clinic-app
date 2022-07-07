import 'dart:convert';

import 'dart:ffi';

import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:my_clinic/services/api.dart';

class Backend {
  static final storage = FlutterSecureStorage();

  static final dio = Api().api;

  static AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  //  IOSOptions _getIOSOptions() => IOSOptions(
  //   accountName: _getAccountName(),
  // );

  // static dioGetRequest() async {
  //   print('runing before Try and Catch BLOCK');

  //   try {
  //     final response = await dio.get(TodoEndPoint);

  //     print('runing');

  //     if (response.statusCode == 200) {
  //       debugPrint('$response');

  //       debugPrint('resonse from server');
  //       debugPrint('resonse == ${response.statusCode} from server');
  //       debugPrint(response.data.toString());
  //       return response.data;
  //     } else {
  //       print(response.statusCode);
  //     }
  //   } on DioError catch (e) {
  //     debugPrint('error While Getting data : $e');
  //   }
  // }

  static Future storeEmail(String key, String fullName) {
    return storage.write(
        key: key, value: fullName, aOptions: getAndroidOptions());
  }

  static Future storeToken(String key, String token) async {
    return await storage.write(
        key: key, value: token, aOptions: getAndroidOptions());
  }

  static Future storeRefreshToken(String key, String refreshToken) async {
    return await storage.write(
        key: key, value: refreshToken, aOptions: getAndroidOptions());
  }

  static Future storeJwtForAppointment(String key, String jwt) async {
    return await storage.write(
        key: key, value: jwt, aOptions: getAndroidOptions());
  }

  static Future getToken(String key) async {
    return await storage.read(key: key, aOptions: getAndroidOptions());
  }

  static Future getRefreshToken(String key) async {
    return await storage.read(key: key, aOptions: getAndroidOptions());
  }

  static Future deleteToken() async {
    return await storage.deleteAll(aOptions: getAndroidOptions());
  }
}
