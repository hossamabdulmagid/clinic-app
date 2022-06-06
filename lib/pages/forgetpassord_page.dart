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
  final TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(107, 201, 213, 1),
        title: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          // Container(
          //     alignment: Alignment.center,
          //     padding: const EdgeInsets.all(10),
          //     child: const Text(
          //       'Welcome back to clinic',
          //       style: TextStyle(
          //           color: Color.fromRGBO(107, 201, 213, 1),
          //           fontWeight: FontWeight.w500,
          //           fontSize: 30),
          //     )),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: email,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Color.fromRGBO(107, 201, 213, 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
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
          const SizedBox(
            height: 10,
          ),
          Container(
              constraints:
                  const BoxConstraints.tightFor(width: 380, height: 50),
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(107, 201, 213, 1),
                  // minimumSize: const Size.fromHeight(5),
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
