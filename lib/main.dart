import 'package:flutter/material.dart';
import 'package:my_clinic/pages/login_page.dart';
import 'package:my_clinic/pages/home_page.dart';
import 'package:my_clinic/pages/privacypolicy_page.dart';
import 'package:my_clinic/pages/refundpolicy_page.dart';
import 'package:my_clinic/pages/terms_page.dart';
import 'package:my_clinic/services/backend.dart';
import 'package:my_clinic/services/private-route.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'MY CLINIC';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: non_constant_identifier_names
  var isLoggedIs;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: MyApp._title,
        routes: ConditionalRouter(public: {
          '/': (context) => LoginPage()
        }, private: {
          '/privacy-policy': (context) => PrivacyPolicyPage(),
          '/refund-policy': (context) => RefundPolicyPage(),
          '/terms': (context) => TermsPage(),
          '/home': (context) => HomePage()
        })
        // routes: {
        //   '/': (context) => LoginPage(),
        //   '/privacy-policy': (context) => PrivacyPolicyPage(),
        //   '/refund-policy': (context) => RefundPolicyPage(),
        //   '/terms': (context) => TermsPage(),
        //   '/home': (context) => HomePage()
        // },
        );
  }

  Future<void> checkLogin() async {
    var isLoggedId = await Backend.getToken('token');
  }
}
