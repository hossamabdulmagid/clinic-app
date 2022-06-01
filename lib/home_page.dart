import 'package:flutter/material.dart';
import 'package:my_clinic/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome User'),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: const Icon(Icons.exit_to_app, size: 18),
              label: const Text('Signout')),
        ],
      )),
    ));
  }
}
