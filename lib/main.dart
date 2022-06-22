import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      title: MyApp._title,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/privacy-policy', page: () => PrivacyPolicyPage()),
        GetPage(name: '/refund-policy', page: () => RefundPolicyPage()),
        GetPage(name: '/terms', page: () => TermsPage()),
        GetPage(name: '/home', page: () => HomePage())
      ],
      // routes: ConditionalRouter(public: {
      //   '/': (context) => LoginPage()
      // }, private: {
      //   '/privacy-policy': (context) => PrivacyPolicyPage(),
      //   '/refund-policy': (context) => RefundPolicyPage(),
      //   '/terms': (context) => TermsPage(),
      //   '/home': (context) => HomePage()
      // })
      // routes: {
      //   '/': (context) => LoginPage(),
      //   '/privacy-policy': (context) => PrivacyPolicyPage(),
      //   '/refund-policy': (context) => RefundPolicyPage(),
      //   '/terms': (context) => TermsPage(),
      //   '/home': (context) => HomePage()
      // },
    );
    // noSuchMethodError class 'String' has no Instance getter StatusCode
  }
}
