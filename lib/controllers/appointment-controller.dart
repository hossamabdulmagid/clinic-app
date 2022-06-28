import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_clinic/models/appointment.dart';
import 'package:my_clinic/services/backend.dart';
import 'package:my_clinic/services/jitsi-config.dart';

class AppointmentControllers extends GetxController {
  Appointment? Appointments_list;

  final isLoading = false.obs;

  final checkAppointMentIsEmpty = false.obs;

  final id = ''.obs;
  final secretKey = ''.obs;
  final patientName = ''.obs;
  final jwt_for_appointment = ''.obs;

  void validateAppointment(x, y, z) async {
    try {
      id.value = x;
      secretKey.value = y;
      patientName.value = z;

      var token = await Backend.getToken('token');

      // print('new id while clicking  => $id');
      // print('new Secret Key While Clicking => $secretKey');
      // print('new patientName While Clicking => $patientName');

      if (token.length != 0) {
        var res = await Backend.get(
            'clinic/appointment-validate/$id/$secretKey', token);

        var result = jsonDecode(res);

        var jwt = await Backend.storeJwt(
            'jwt-for-meeting', '${result['data']['jwt']}');

        if ('${result['data']['jwt']}'.isNotEmpty) {
          jwt_for_appointment.value = '${result['data']['jwt']}';
          await Future.delayed(const Duration(seconds: 1));
          print('jwt_for_appointment => $jwt_for_appointment');
          return Get.to(() => Meeting());
        }
      }
    } catch (err) {
      print(err);
    }
  }

  getAppointments() async {
    try {
      var token = await Backend.getToken('token');

      var res = await Backend.get('clinic/my-appointments', token);

      var result = jsonDecode(res);
      print(result);
      print(result);
      print('res from get result $result');

      Appointments_list = Appointment.fromJson(result);
      if (result?['data'].length == 0) {
        print('@@@@@@@@@@@@@@@@@@@@@@@@');
        checkAppointMentIsEmpty(true);
      } else {
        print('##################');
        checkAppointMentIsEmpty(false);
      }
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
