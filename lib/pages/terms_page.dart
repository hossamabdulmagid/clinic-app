import 'package:flutter/material.dart';
import 'package:my_clinic/pages/login_page.dart';

class TermsPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Terms Of Services'),
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
