import 'package:flutter/material.dart';
import 'package:my_clinic/pages/login_page.dart';
import 'package:my_clinic/pages/privacypolicy_page.dart';
import 'package:my_clinic/pages/refundpolicy_page.dart';
import 'package:my_clinic/pages/terms_page.dart';
import 'package:my_clinic/pages/welcome_user.dart';
import 'package:my_clinic/services/backend.dart';

class HomePage extends StatefulWidget {
  @override

  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // ignore: non_constant_identifier_names
  final Screen = [
    Welcome(),
    PrivacyPolicyPage(),
    RefundPolicyPage(),
    TermsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(107, 201, 213, 1),
          title: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Screen[currentIndex],
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
        ));
  }
}
