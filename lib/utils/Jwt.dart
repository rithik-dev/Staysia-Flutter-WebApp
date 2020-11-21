import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:staysia_web/main.dart';
import 'package:staysia_web/utils/get_dio.dart';

class Jwt extends GetxController {
  RxString token = ''.obs;
  void setToken(String jwt) {
    logger.d('jwt: $jwt');
    token.value = jwt;
  }
}
