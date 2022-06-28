import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_clinic/pages/login_page.dart';
import 'package:my_clinic/pages/home_page.dart';
import 'package:my_clinic/services/jitsi-config.dart';

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
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/appointment/:id/:secretKey', page: () => Meeting())
      ],
    );
  }
}
