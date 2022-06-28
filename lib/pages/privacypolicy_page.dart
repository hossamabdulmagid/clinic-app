import 'package:flutter/material.dart';
import 'package:my_clinic/pages/login_page.dart';

// ignore: use_key_in_widget_constructors
class PrivacyPolicyPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  // var html =
  //     "Follow<a class='sup'>pl</a> what was sent down to you from your Lord, and do not follow other guardians apart from Him. Little do <p class='h'>you remind yourselves</p><a class='f'><sup f=2437>1</a>.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys'
                      'standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book'
                      'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.'
                      'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages'
                      ' and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'
                      '  Why do we use it? It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout'
                      '  The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using '
                      'Content here, content here'
                      'making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for '
                      ' lorem ipsum '
                      ' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            )),
      ),
    );
  }
}
