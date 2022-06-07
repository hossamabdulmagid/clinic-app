import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_clinic/services/backend.dart';

Future<Clinic> getClinic() async {
  final token = await Backend.getToken('token');

  final response = await Backend.get('clinic/', token);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response);
    print('repsone from GetClinic');
    return Clinic.fromJson(json.decode(response.body?.data));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Clinic {
  final bool success;
  final List<Data> data;

  const Clinic({
    required this.success,
    required this.data,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    print(list.runtimeType);
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return Clinic(success: json['success'], data: dataList);
  }
}

/*

  "_id": "6270321a0584c700120df0ae",
            "name": "KIMI clinic",
            "phone": "+18184419136",
            "email": "royal@clinic.health",
*/
class Data {
  final int id;
  final String name;
  final String phone;
  final String email;

  Data(
      {required this.id,
      required this.name,
      required this.phone,
      required this.email});

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
      id: parsedJson['id'],
      name: parsedJson['name'],
      phone: parsedJson['phone'],
      email: parsedJson['email'],
    );
  }
}
