import 'package:flutter/material.dart';
import 'package:my_clinic/pages/login_page.dart';

// ignore: use_key_in_widget_constructors
class PrivacyPolicyPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Privacy Polic Page'),
          const SizedBox(
            height: 30,
          ),
          // OutlinedButton.icon(
          //     onPressed: () {
          //       // Navigator.pop(context,
          //       //     MaterialPageRoute(builder: (context) => LoginPage()));
          //     },
          //     icon: const Icon(Icons.exit_to_app, size: 18),
          //     label: const Text('')),
        ],
      )),
    ));
  }
}
