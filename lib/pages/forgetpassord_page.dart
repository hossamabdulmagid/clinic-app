// ignore: unnecessary_import
// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:my_clinic/pages/home_page.dart';

class ForgetPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  TextEditingController emailController = TextEditingController();

  String buttonName = 'ResetPassword';

  bool isLoading = false;

  var url = Uri.encodeFull('https://base.maado.me/api/v1/auth/login');

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  final TextEditingController email = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Welcome back to clinic',
                style: TextStyle(
                    color: Color.fromRGBO(107, 201, 213, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: email,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(107, 201, 213, 1)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(107, 201, 213, 1)),
                ),
                labelText: 'Email/Phone',
                labelStyle: TextStyle(
                  color: Color.fromRGBO(107, 201, 213, 1),
                ),
              ),
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(107, 201, 213, 1),
                  minimumSize: const Size.fromHeight(40),
                ),
                onPressed: () {
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: const Text("Reset Password"),
              )),
        ],
      ),
    );
  }

  // Future<void> ForgetPassword(String email) async {
  //   final body = jsonEncode({
  //     "login": nameController.text,
  //     "password": passwordController.text,
  //     "type": "client",
  //     "clinicId": "6270321a0584c700120df0ae",
  //   });

  //   if (nameController.text.isNotEmpty || passwordController.text.isNotEmpty) {
  //     final response = await http.post(
  //       Uri.parse('https://base.maado.me/api/v1/auth/login'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //         "login": login,
  //         "password": password,
  //         "type": "client",
  //         "clinicId": "6270321a0584c700120df0ae",
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       // ignore: use_build_context_synchronously
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => HomePage()));
  //     } else {
  //       // ignore: use_build_context_synchronously
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Invalid Credenialse...')));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('Empty Field Not Allowed Pleace Get In Touch...')));
  //   }
  // }
}
