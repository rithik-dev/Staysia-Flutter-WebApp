import 'package:dio/dio.dart';
import 'package:staysia_web/utils/get_dio.dart';

class UserController {
  static final Dio _dio = getDioInstance();

  static Future signupController(
      {String name,
      String email,
      String password,
      String phone_number}) async {}

  static Future googleSignupController() async {}

  static Future loginController({
    String email,
    String password,
  }) async {}

  static Future logoutController() async {}

  static Future getProfileController() async {}

  static Future patchProfileController() async {}
}
