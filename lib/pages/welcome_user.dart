import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import

import 'package:my_clinic/controllers/appointment-controller.dart';
// ignore: unused_import
import 'package:my_clinic/models/appointment.dart';
// ignore: unused_import
import 'package:my_clinic/pages/clinic.dart';
// ignore: unused_import
import 'package:my_clinic/pages/login_page.dart';
import 'package:my_clinic/services/backend.dart';
// ignore: unused_import
import 'package:url_launcher/url_launcher.dart';
// ignore: depend_on_referenced_packages
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

  final AppointmentControllers appointmentcontrollers =
      Get.put(AppointmentControllers());

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
    appointmentcontrollers.GetAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => appointmentcontrollers.isLoading.isTrue
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
                itemCount: appointmentcontrollers.Appointments_list?.data ==
                        null
                    ? 0
                    : appointmentcontrollers.Appointments_list?.data?.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffdddddd),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(26.0),
                      child: InkWell(
                          child: Text(
                              'Doctor:- ${appointmentcontrollers.Appointments_list?.data?[index].doctorName}'
                              ' \n'
                              'start:- ${utcTo12HourFormatToLocal(appointmentcontrollers.Appointments_list?.data?[index].startDate)}'
                              ' \n'
                              'join Appointment',
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                              )),
                          onTap: () => {
                                appointmentcontrollers.updatedIdSecretKey(
                                    '${appointmentcontrollers.Appointments_list?.data?[index].sId.toString()}',
                                    '${appointmentcontrollers.Appointments_list?.data?[index].secretKey.toString()}'),
                                // launch(
                                //     'https://docs.flutter.io/flutter/services/UrlLauncher-class.html')
                              }),
                    ),
                  );
                },
              ),
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
}
