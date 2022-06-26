// ignore: unnecessary_import
import 'dart:convert';

// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:my_clinic/pages/home_page.dart';
import 'package:http/http.dart' as http;

import 'package:my_clinic/pages/forgetpassord_page.dart';
import 'package:my_clinic/pages/privacypolicy_page.dart';
import 'package:my_clinic/pages/terms_page.dart';
import 'package:my_clinic/services/backend.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  String? token;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  String buttonName = 'Sign In...';

  bool isLoading = false;

  static const storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(107, 201, 213, 1),
          title: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
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
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
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
                    Get.to(() => ForgetPage());
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //   return ForgetPage();
                    // }));
                  },
                  child: const Text('Forgot Password',
                      style:
                          TextStyle(color: Color.fromRGBO(107, 201, 213, 1))),
                ),
                Container(
                    constraints:
                        const BoxConstraints.tightFor(width: 370, height: 50),
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(
                            107, 201, 213, 1), // Background color
                      ),
                      onPressed: () async {
                        if (isLoading) {
                          return;
                        }
                        setState(() {
                          isLoading = true;
                        });
                        await Future.delayed(const Duration(seconds: 2));
                        await Login(
                            nameController.text, passwordController.text);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Please wait...'),
                                SizedBox(
                                  // ignore: sort_child_properties_last
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  height: 20.0,
                                  width: 20.0,
                                ),
                              ],
                            )
                          : const Text("Sign In..."),
                    )),
              ],
            )));
  }

  Future<void> Login(String login, String password) async {
    final body = jsonEncode({
      "login": nameController.text,
      "password": passwordController.text,
      "type": "client",
      "clinicId": "6270321a0584c700120df0ae",
    });

    if (nameController.text.isNotEmpty || passwordController.text.isNotEmpty) {
      var response = await Backend.post(body, "auth/login");

      if (response['error'] != null) {
        print('respone $response');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${response?['error']['message']}')));
      } else if (response['data']['token'] != null) {
        await Backend.storeToken('token', '${response['data']['token']}');

        await Backend.storeEmail(
            'fullName',
            '${response['data']['user']['firstName']}'
                ' '
                '${response['data']['user']['lastName']}');

        var target = await Backend.getToken('fullName');
        var token = await Backend.getToken('token');
        print('token $token');
        // print('token => $token');
        // ignore: use_build_context_synchronously
        Get.to(() => HomePage());
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Empty Field Not Allowed Pleace Get In Touch...')));
    }
  }
}
