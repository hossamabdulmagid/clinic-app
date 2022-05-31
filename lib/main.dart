import 'package:flutter/material.dart';
import 'package:my_clinic/login_page.dart';
import 'package:my_clinic/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'MY CLINIC';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: MyApp._title,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(107, 201, 213, 1),
            title: const Center(child: Text(MyApp._title))),
        body: LoginPage(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromRGBO(107, 201, 213, 1),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.privacy_tip,
                  color: Color.fromRGBO(107, 201, 213, 1),
                ),
                label: 'Terms of Service',
                icon: Icon(Icons.privacy_tip,
                    color: Colors.grey,
                    semanticLabel: "Read Privacy Policy",
                    size: 22.0)),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.key,
                  color: Color.fromRGBO(107, 201, 213, 1),
                ),
                label: 'Refund Policy',
                icon: Icon(Icons.key,
                    color: Colors.grey,
                    semanticLabel: "Read Privacy Policy",
                    size: 22.0)),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.privacy_tip_rounded,
                  color: Color.fromRGBO(107, 201, 213, 1),
                ),
                label: 'Privacy Policy.',
                icon: Icon(
                  Icons.privacy_tip_rounded,
                  color: Colors.grey,
                  size: 22.0,
                  semanticLabel: "Read Privacy Policy",
                ))
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
