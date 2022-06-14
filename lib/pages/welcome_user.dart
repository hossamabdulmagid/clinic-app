import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_clinic/pages/clinic.dart';
import 'package:my_clinic/pages/login_page.dart';
import 'package:my_clinic/services/backend.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:intl/intl.dart';

class Welcome extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List? datax;
  List? validAppointments;
  late bool Loading = true;
  String? name;

  String utcTo12HourFormatToLocal(String utcTime) {
    var dateFormat =
        DateFormat("dd/MM/yyyy hh:mm aa"); // you can change the format here
    var utcDate =
        dateFormat.format(DateTime.parse(utcTime)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    String startDate =
        dateFormat.format(DateTime.parse(localDate)); // you will local time
    return startDate;
  }

  @override
  void initState() {
    super.initState();
    getClinic();
    GetAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (validAppointments?.isEmpty ?? true)
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('Dont have valid Appointments',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold)),
              ],
            ))
          : ListView.builder(
              // ignore: unnecessary_null_comparison
              itemCount:
                  validAppointments == null ? 0 : validAppointments?.length,
              // scrollDirection: Axis.vertical,

              // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        // ignore: avoid_unnecessary_containers
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(0xffdddddd),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(26.0),
                          child: Text(
                              'Doctor:- ${validAppointments?[index]['doctorName']}'
                              ' \n'
                              'start:- ${utcTo12HourFormatToLocal(validAppointments?[index]['startDate'])}'
                              ' \n'
                              'end:- ${utcTo12HourFormatToLocal(validAppointments?[index]['endDate'])}',
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Future<String> getClinic() async {
    var token = await Backend.getToken('token');
    var res = await Backend.get('clinic/', token);

    setState(() {
      dynamic resBody = json.decode(res);
      datax = resBody['data'];
    });
    return 'Success!';
  }

  // ignore: non_constant_identifier_names
  Future<String> GetAppointments() async {
    var token = await Backend.getToken('token');
    var res = await Backend.get('clinic/my-appointments', token);
    setState(() {
      dynamic resBody = json.decode(res);
      validAppointments = resBody['data'];
      print('validAppointments $validAppointments');
    });
    return 'Success!';
  }
}
