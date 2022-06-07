import 'package:flutter/material.dart';
import 'package:my_clinic/pages/clinic.dart';
import 'package:my_clinic/pages/login_page.dart';
import 'package:my_clinic/services/backend.dart';

class Welcome extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late Future<Clinic> futureClinic;

  @override
  void initState() {
    super.initState();
    futureClinic = getClinic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You Are Welcome'),
            const SizedBox(
              height: 30,
            ),
            FutureBuilder<Clinic>(
                future: futureClinic,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Map<String, dynamic>> data =
                        snapshot.data as List<Map<String, dynamic>>;
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text("${data[index]["name"]}");
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            // FutureBuilder<Clinic>(
            //   future: futureClinic,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return Text(snapshot.data!.name);
            //     } else if (snapshot.hasError) {
            //       return Text('${snapshot.error}');
            //     }

            //     // By default, show a loading spinner.
            //     return const CircularProgressIndicator();
            //   },
            // ),
            OutlinedButton.icon(
                onPressed: () async {
                  var token = await Backend.getToken('token');

                  print('token is ===');
                  print(token);

                  var result = await Backend.deleteToken('token');
                  print(result);
                  print('result');
                  Navigator.pushNamed(context, '/');
                },
                icon: const Icon(Icons.exit_to_app, size: 18),
                label: const Text('Signout')),
          ],
        )),
      ),
    );
  }
}
