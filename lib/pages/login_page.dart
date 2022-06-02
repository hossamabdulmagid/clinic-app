// ignore: unnecessary_import
import 'dart:convert';

// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:my_clinic/pages/home_page.dart';
import 'package:http/http.dart' as http;

import 'package:my_clinic/pages/forgetpassord_page.dart';

class LoginPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  String buttonName = 'Sign In...';

  bool isLoading = false;

  var url = Uri.encodeFull('https://base.maado.me/api/v1/auth/login');

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
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
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  '',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
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
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(107, 201, 213, 1)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(107, 201, 213, 1)),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(107, 201, 213, 1),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ForgetPage();
                }));
              },
              child: const Text('Forgot Password',
                  style: TextStyle(color: Color.fromRGBO(107, 201, 213, 1))),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(
                        107, 201, 213, 1), // Background color
                  ),
                  onPressed: () {
                    Login(nameController.text, passwordController.text);
                  },
                  child: Text("Sign In..."),
                )),
            Row(
              // ignore: sort_child_properties_last
              children: <Widget>[
                const Text('By clicking "Sign in" you agree to our'),
                TextButton(
                  child: const Text(
                    'Terms of Service',
                    style: TextStyle(color: Color.fromRGBO(107, 201, 213, 1)),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }

  Future<void> Login(String login, String password) async {
    final body = jsonEncode({
      "login": nameController.text,
      "password": passwordController.text,
      "type": "client",
      "clinicId": "6270321a0584c700120df0ae",
    });

    if (nameController.text.isNotEmpty || passwordController.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse('https://base.maado.me/api/v1/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "login": login,
          "password": password,
          "type": "client",
          "clinicId": "6270321a0584c700120df0ae",
        }),
      );

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Credenialse...')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Empty Field Not Allowed Pleace Get In Touch...')));
    }
  }
}
