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

  final checkAppointMentIsEmpty = false.obs;

  final id = ''.obs;
  final secretKey = ''.obs;

  void updatedIdSecretKey(d, s) async {
    try {
      id.value = d;
      secretKey.value = s;
      var token = await Backend.getToken('token');

      print('new id while clicking $id');
      print('new Secret Key While Clicking $secretKey');
      var resz = await Backend.get(
          'clinic/appointment-validate/$id/$secretKey', token);

      var resultzzz = jsonDecode(resz);

      var jwt = await Backend.storeJwt('jwt', '${resultzzz['data']['jwt']}');

      var resultJwt = await Backend.getToken('jwt');

      print('jwt heheheheh $jwt');

      print('resultJwt heheheheh $resultJwt');

      print(
          'print jwt  Response From Valid Appointment  result =>>> ${resultzzz['data']['jwt']}');
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
