import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:my_clinic/models/appointment.dart';
import 'package:my_clinic/services/backend.dart';

class AppointmentControllers extends GetxController {
  // List<Appointment> Appointments = <Appointment>[].obs;

  Appointment? Appointments_list;

  final isLoading = false.obs;
  // ignore: non_constant_identifier_names
  GetAppointments() async {
    try {
      var token = await Backend.getToken('token');

      var res = await Backend.get('clinic/my-appointments', token);

      var result = jsonDecode(res);

      Appointments_list = Appointment.fromJson(result);

      isLoading(true);
    } catch (err) {
      print('err while getting data $err');
    } finally {
      isLoading(false);
    }
  }
}
