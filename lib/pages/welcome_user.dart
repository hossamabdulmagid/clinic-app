import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_clinic/pages/clinic.dart';
import 'package:my_clinic/pages/login_page.dart';
import 'package:my_clinic/services/backend.dart';

class Welcome extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List? datax;
  late bool Loading = true;
  String? name;

  @override
  void initState() {
    super.initState();
    getClinic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          // ignore: unnecessary_null_comparison
          itemCount: datax == null ? 0 : datax?.length,
          // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
          itemBuilder: (BuildContext context, int index) {
            return Center(
                child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(26.0),
                    child: Text(datax?[index]['name'],
                        style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Card(
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(26.0),
                    child: Text(datax?[index]['email'],
                        style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Card(
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(26.0),
                    child: Text(datax?[index]['phone'],
                        style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                OutlinedButton.icon(
                    onPressed: () async {
                      var token = await Backend.getToken('token');
                      print('token is ===');
                      print(token);

                      var result = await Backend.deleteToken('token');
                      var target = await Backend.deleteToken('fullName');

                      print(result);

                      print('result');

                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, '/');
                    },
                    icon: const Icon(Icons.exit_to_app, size: 18),
                    label: const Text('Signout')),
              ],
            ));
          }),
    );
  }

  Future<String> getClinic() async {
    var token = await Backend.getToken('token');
    var res = await Backend.get('clinic/', token);

    setState(() {
      dynamic resBody = json.decode(res);
      datax = resBody['data'];
    });

    return 'Success!';
  }
}
