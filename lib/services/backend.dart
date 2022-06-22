// ignore: file_names
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

abstract class Backend {
  static final client = http.Client();

  static final storage = FlutterSecureStorage();

  static AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  //  IOSOptions _getIOSOptions() => IOSOptions(
  //   accountName: _getAccountName(),
  // );

  static get(String endpoint, String token) async {
    var response = await client.get(buildUrl(endpoint), headers: {
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });

    if (response.statusCode == 200) {
      print('you now have already req.body');
      return response.body;
    } else {
      return response;
    }
  }

  static Future post(body, String endpoint) async {
    var response = await client.post(buildUrl(endpoint),
        body: body,
        headers: {'Content-Type': 'application/json; charset=UTF-8'});
    if (response.statusCode == 200) {
      var target = json.decode(response.body);
      return target;
    } else {
      var result = response.body;
      return json.decode(result);
    }
  }

  static Uri buildUrl(String endPoint) {
    String host = 'https://base.maado.me/api/v1/';
    final apiPath = host + endPoint;
    return Uri.parse(apiPath);
  }

  static Future storeEmail(String key, String fullName) {
    return storage.write(
        key: key, value: fullName, aOptions: getAndroidOptions());
  }

  static Future storeToken(String key, String token) async {
    return await storage.write(
        key: key, value: token, aOptions: getAndroidOptions());
  }

  static Future getToken(String key) async {
    return await storage.read(key: key, aOptions: getAndroidOptions());
  }

  static Future deleteToken(String key) async {
    return await storage.deleteAll();
  }
}
