// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SignUpSection(),
//       routes: {
//         LandingScreen.id: (context) => LandingScreen(),
//         LoginSection.id: (context) => LoginSection(),
//         LogoutScreen.id: (context) => LogoutScreen(),
//         Private.id: (context) => Private(),
//       },
//     );
//   }
// }

// class SignUpSection extends StatelessWidget {
//   var email;
//   var password;

//   @override
//   Widget build(BuildContext context) {
//     checkToken() async {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String token = prefs.getString("token");
//       if (token != null) {
//         Navigator.pushNamed(context, LandingScreen.id);
//       }
//     }

//     checkToken();
//     return CupertinoPageScaffold(
//         navigationBar: CupertinoNavigationBar(
//           automaticallyImplyLeading: false,
//         ),
//         child: SafeArea(
//             child: ListView(padding: const EdgeInsets.all(16), children: [
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: CupertinoTextField(
//                   placeholder: "Email",
//                   onChanged: (value) {
//                     email = value;
//                   })),
//           Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: CupertinoTextField(
//                   placeholder: "Password",
//                   obscureText: true,
//                   onChanged: (value) {
//                     password = value;
//                   })),
//           FlatButton.icon(
//             onPressed: () async {
//               await signup(email, password);
//               SharedPreferences prefs = await SharedPreferences.getInstance();
//               String token = prefs.getString("token");
//               if (token != null) {
//                 Navigator.pushNamed(context, LandingScreen.id);
//               }
//             },
//             icon: Icon(Icons.save),
//             label: Text("Sign UP"),
//           ),
//           FlatButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, LoginSection.id);
//               },
//               child: Text("login")),
//         ])));
//   }
// }

// signup(email, password) async {
//   var url = "http://localhost:5000/signup"; // iOS
//   final http.Response response = await http.post(
//     url,
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'email': email,
//       'password': password,
//     }),
//   );
//   print(response.body);
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var parse = jsonDecode(response.body);

//   await prefs.setString('token', parse["token"]);
// }

// class LoginSection extends StatelessWidget {
//   static const String id = "LoginSection";
//   var email;
//   var password;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: CupertinoPageScaffold(
//           navigationBar: CupertinoNavigationBar(
//             automaticallyImplyLeading: false,
//           ),
//           child: SafeArea(
//               child: ListView(padding: const EdgeInsets.all(16), children: [
//             Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 child: CupertinoTextField(
//                     placeholder: "Email",
//                     onChanged: (value) {
//                       email = value;
//                     })),
//             Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 child: CupertinoTextField(
//                     placeholder: "Password",
//                     obscureText: true,
//                     onChanged: (value) {
//                       password = value;
//                     })),
//             FlatButton.icon(
//                 onPressed: () async {
//                   await login(email, password);
//                   SharedPreferences prefs =
//                       await SharedPreferences.getInstance();
//                   String token = prefs.getString("token");
//                   print(token);
//                   if (token != null) {
//                     Navigator.pushNamed(context, LandingScreen.id);
//                   }
//                 },
//                 icon: Icon(Icons.save),
//                 label: Text("Login"))
//           ]))),
//     );
//   }
// }

// login(email, password) async {
//   var url = "http://localhost:5000/login"; // iOS
//   final http.Response response = await http.post(
//     url,
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'email': email,
//       'password': password,
//     }),
//   );
//   print(response.body);
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var parse = jsonDecode(response.body);

//   await prefs.setString('token', parse["token"]);
// }

// class LandingScreen extends StatelessWidget {
//   static const String id = "LandingScreen";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Center(child: Text("Welcome to the Landing Screen")),
//         ],
//       ),
//       bottomNavigationBar: BottomNav(),
//     );
//   }
// }

// class BottomNav extends StatefulWidget {
//   BottomNav({Key? key}) : super(key: key);

//   @override
//   _BottomNavState createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> {
//   int _selectedIndex = 0;
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       if (index == 0) {
//         Navigator.pushNamed(context, LandingScreen.id);
//       }
//       if (index == 1) {
//         Navigator.pushNamed(context, Private.id);
//       }
//       if (index == 2) {
//         Navigator.pushNamed(context, LogoutScreen.id);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           title: Text('Home'),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.business),
//           title: Text('Business'),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.school),
//           title: Text('Logout'),
//         ),
//       ],
//       currentIndex: _selectedIndex,
//       selectedItemColor: Colors.amber[800],
//       onTap: _onItemTapped,
//     );
//   }
// }

// class LogoutScreen extends StatelessWidget {
//   static const String id = "LogoutScreen";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Center(child: Text("Logout")),
//           FlatButton.icon(
//             onPressed: () async {
//               SharedPreferences prefs = await SharedPreferences.getInstance();
//               await prefs.setString('token', null);
//               Navigator.pushNamed(context, LoginSection.id);
//             },
//             icon: Icon(Icons.send),
//             label: Text("Logout"),
//           )
//         ],
//       ),
//       bottomNavigationBar: BottomNav(),
//     );
//   }
// }

// Future<Album> fetchAlbum() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String token = prefs.getString("token");
//   print(token);

//   final response = await http.get(
//     'http://localhost:5000/private',
//     headers: {"token": token},
//   );

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(json.decode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// class Album {
//   final String msg;

//   Album({this.msg});

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       msg: json['msg'],
//     );
//   }
// }

// class Private extends StatefulWidget {
//   static const String id = "Private";
//   Private({Key key}) : super(key: key);

//   @override
//   _PrivateState createState() => _PrivateState();
// }

// class _PrivateState extends State<Private> {
//   Future<Album> futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Scaffold(
//         appBar: AppBar(
//           title: Text('Fetch Data Example'),
//         ),
//         body: Center(
//           child: FutureBuilder<Album>(
//             future: futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Text(snapshot.data.msg);
//               } else if (snapshot.hasError) {
//                 return Text("${snapshot.error}");
//               }

//               // By default, show a loading spinner.
//               return CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNav(),
//     );
//   }
// }
