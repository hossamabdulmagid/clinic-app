// ignore: unnecessary_import
import 'dart:convert';

// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  // void onInit() {
  //   // super.onInit();
  //   checkLogin();
  // }

  // void checkLogin() async {
  //   var scopeToken = await Backend.getToken();
  //   print(scopeToken);
  //   print('scopeToken');
  //   var response = Backend.get('clinic/', scopeToken);
  //   print(response);

  //   if (scopeToken != null) {
  //     token = scopeToken;
  //     print(token);
  //     print('token');
  //     var response = Backend.get('clinic/', scopeToken);
  //     print(response);
  //   }
  // }

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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ForgetPage();
                    }));
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
                      onPressed: () {
                        Login(nameController.text, passwordController.text);
                      },
                      child: Text("Sign In..."),
                    )),
                // Row(
                //   // ignore: sort_child_properties_last
                //   children: <Widget>[
                //     const Text('By clicking "Sign in" you agree to our'),
                //     TextButton(
                //       child: const Text(
                //         'Terms of Service',
                //         style: TextStyle(color: Color.fromRGBO(107, 201, 213, 1)),
                //       ),
                //       onPressed: () {
                //         // Navigator.of(context).push(
                //         //     MaterialPageRoute(builder: (BuildContext context) {
                //         //   return TermsPage();
                //         // }));
                //       },
                //     )
                //   ],
                //   mainAxisAlignment: MainAxisAlignment.center,
                // ),
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
    // Backend.storage.deleteAll();
    if (nameController.text.isNotEmpty || passwordController.text.isNotEmpty) {
      var response = await Backend.post(body, "auth/login");

      var data = json.decode(response);

      var ValidT = await Backend.getToken('token');

      // print(data['error']['message']);

      print('response');

      Map<String, dynamic> token = jsonDecode(response);

      print(data);
      print('data');

      // print(response);
      // print('response');
      // print(data['data']['user'].length);
      // print(data['data'].length);
      // print('datalength');

      if (data.isNotEmpty) {
        await Backend.storeToken('token', '${token['data']['token']}');

        print('token =====');

        print(ValidT);

        print('your Token Is, ${token['data']['token']}!');

        print('We sent the verification link to ${token['data']}.');

        print('result');

        // ignore: use_build_context_synchronously
        print(data);

        print(data);

        print('dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaXX');

        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Credenialse...')));
      }

      var result = await Backend.get('clinic/', ValidT);

      result.then((x) => print(x));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Empty Field Not Allowed Pleace Get In Touch...')));
    }
    // print(Backend.storage.readAll());
    // print('Backend.storage.readAll()');

    // print('allValue');
    // print('target');

    // await Backend.getToken('token');

    // var result = Backend.get('clinic/', await Backend.getToken('token'));
    // print(result);
    // print(data.token);
    // print(json.decode(data.body));
    // await Backend.storeToken(data.token);

    // var scopeToken = await Backend.getToken();

    // if (scopeToken != null) {
    //   // token?.value = scopeToken;
    //   var res = await Backend.get('clinic/', scopeToken);
    //   print(res);
    // }
    // print(scopeToken);
    // print('scopeToken');

    // if (scopeToken != null) {
    //   token = scopeToken;
    //   print(token);
    //   print('token');
    //   var response = Backend.get('clinic/', scopeToken);
    //   print(response);
    // }
    // checkLogin();
    // await NetWorkHandler.getToken('token').then((value) => print(value));
    // print(response);

    // final response = await http.post(
    //   Uri.parse('https://base.maado.me/api/v1/auth/login'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     "login": login,
    //     "password": password,
    //     "type": "client",
    //     "clinicId": "6270321a0584c700120df0ae",
    //   }),
    // );
  }
}
