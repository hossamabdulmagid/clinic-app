import 'package:flutter/material.dart';
import 'package:my_clinic/pages/login_page.dart';

class Welcome extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
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
                  Navigator.pushNamed(context, '/');
                },
                icon: const Icon(Icons.exit_to_app, size: 18),
                label: const Text('Signout')),
          ],
        )),
      ),
    );
  }
}
