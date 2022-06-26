import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:my_clinic/models/appointment.dart';
import 'package:my_clinic/services/api.dart';
import 'package:my_clinic/services/backend.dart';
import 'package:dio/dio.dart';

class AppointmentControllers extends GetxController {
  Appointment? Appointments_list;

  final isLoading = false.obs;

  var id = ''.obs;
  var secretKey = ''.obs;

  void updatedIdSecretKeyZ(d, s) async {
    try {
      id.value = d;
      secretKey.value = s;
      var token = await Backend.getToken('token');

      print('new id while clicking $id');
      print('new Secret Key While Clicking $secretKey');
      var resz = await Backend.get(
          'clinic/appointment-validate/$id/$secretKey', token);

      var resultzzz = jsonDecode(resz);

      print(
          'print jwt  Response From Valid Appointment  result =>>> ${resultzzz['data']}');
    } catch (err) {
      print(err);
    }
  }

  GetAppointments() async {
    try {
      var token = await Backend.getToken('token');

      var res = await Backend.get('clinic/my-appointments', token);

      var result = jsonDecode(res);
      print(result);
      print(result);
      print('res from get result $result');

      Appointments_list = Appointment.fromJson(result);

      isLoading(true);
    } on TypeError {
      print(TypeError());
    } catch (err) {
      print('err while getting data $err');
    } finally {
      isLoading(false);
    }
  }
}
