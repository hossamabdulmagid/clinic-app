import 'package:flutter/material.dart';
import 'package:my_clinic/pages/login_page.dart';
import 'package:my_clinic/pages/home_page.dart';
import 'package:my_clinic/pages/privacypolicy_page.dart';
import 'package:my_clinic/pages/refundpolicy_page.dart';
import 'package:my_clinic/pages/terms_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'MY CLINIC';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // ignore: non_constant_identifier_names
  final Screen = [
    LoginPage(),
    PrivacyPolicyPage(),
    RefundPolicyPage(),
    TermsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: MyApp._title,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(107, 201, 213, 1),
            title: const Center(child: Text(MyApp._title))),
        body: Center(
          child: Screen[currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromRGBO(107, 201, 213, 1),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.home,
                  color: Color.fromRGBO(107, 201, 213, 1),
                ),
                label: 'Home',
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                  size: 22.0,
                )),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.privacy_tip,
                  color: Color.fromRGBO(107, 201, 213, 1),
                ),
                label: 'Terms',
                icon: Icon(Icons.privacy_tip, color: Colors.grey, size: 22.0)),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.key,
                  color: Color.fromRGBO(107, 201, 213, 1),
                ),
                label: 'Refund',
                icon: Icon(Icons.key, color: Colors.grey, size: 22.0)),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.privacy_tip_rounded,
                  color: Color.fromRGBO(107, 201, 213, 1),
                ),
                label: 'Privacy',
                icon: Icon(
                  Icons.privacy_tip_rounded,
                  color: Colors.grey,
                  size: 22.0,
                )),
          ],
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
