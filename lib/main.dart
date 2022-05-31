// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      title: MyApp._title,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(107, 201, 213, 1),
            title: const Center(child: Text(MyApp._title))),
        body: const MyStatefulWidget(),
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

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String buttonName = 'Sign In...';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Welcome back to clinic',
                  style: TextStyle(
                      color: Color.fromRGBO(107, 201, 213, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  '',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(107, 201, 213, 1)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(107, 201, 213, 1)),
                  ),
                  labelText: 'Email/Phone',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(107, 201, 213, 1),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(107, 201, 213, 1)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(107, 201, 213, 1)),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(107, 201, 213, 1),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password',
                  style: TextStyle(color: Color.fromRGBO(107, 201, 213, 1))),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(
                        107, 201, 213, 1), // Background color
                  ),
                  onPressed: () {
                    setState(() {
                      buttonName = 'Loading...';
                    });
                    print(nameController.text);
                    print(passwordController.text);
                  },
                  child: Text(buttonName),
                )),
            Row(
              // ignore: sort_child_properties_last
              children: <Widget>[
                const Text('By clicking "Sign in" you agree to our'),
                TextButton(
                  child: const Text(
                    'Terms of Service',
                    style: TextStyle(color: Color.fromRGBO(107, 201, 213, 1)),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
