import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_clinic/models/appointment.dart';
import 'package:my_clinic/services/api.dart';
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
  final baseUrl = 'http://192.168.1.12/api/v1';
  final baseUrlProduction = 'https://base.maado.me/api/v1';

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
        var response = await Backend.dio.get(
            '$baseUrlProduction/clinic/appointment-validate/$id/$secretKey');

        if (response.statusCode == 200) {
          print('rez.status comde is ${response.statusCode}');

          print('rez@@Z@ $response');
          var result = response.data;
          print('result => $result @@ result');

          var jwt = await Backend.storeJwtForAppointment(
              'jwt-for-meeting', '${result['data']['jwt']}');

          if ('${result['data']['jwt']}'.isNotEmpty) {
            jwt_for_appointment.value = '${result['data']['jwt']}';
            await Future.delayed(const Duration(seconds: 1));
            debugPrint('jwt_for_appointment => $jwt_for_appointment');
            return Get.to(() => Meeting());
          }
        }
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  getAppointments() async {
    try {
      var token = await Backend.getToken('token');

      var res =
          await Backend.dio.get('$baseUrlProduction/clinic/my-appointments');

      if (res.statusCode == 200) {
        var result = res.data;
        print('res from get clinic/my-appointments => $result');

        Appointments_list = Appointment.fromJson(result);
        if (result?['data'].length == 0) {
          checkAppointMentIsEmpty(true);
        } else {
          checkAppointMentIsEmpty(false);
        }
        isLoading(true);
        return res.data;
      }
    } on DioError catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
