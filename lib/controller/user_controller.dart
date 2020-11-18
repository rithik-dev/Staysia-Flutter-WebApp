import 'package:dio/dio.dart';
import 'package:staysia_web/utils/get_dio.dart';
import 'package:staysia_web/utils/routes.dart';

import '../main.dart';

class UserController {
  static final Dio _dio = getDioInstance();

  static Future<String> signupController(
      {String name, String email, String password, String phone_number}) async {
    try {
      final res = await _dio.post(signup, data: {
        'name': name,
        'email': email,
        'password': password,
        'phone_number': phone_number
      });
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return (res.data['jwt'] as String);
      } else {
        return '';
      }
    } catch (e) {
      logger.e(e);
      return '';
    }
  }

  static Future googleSignupController() async {
    try {
      final res = await _dio.get(googleSignup);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return (res.data['jwt'] as String);
      } else {
        return '';
      }
    } catch (e) {
      logger.e(e);
      return '';
    }
  }

  static Future loginController({
    String email,
    String password,
  }) async {
    try {
      final res =
          await _dio.post(login, data: {'password': password, 'email': email});
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return (res.data['jwt'] as String);
      } else {
        return '';
      }
    } catch (e) {
      logger.e(e);
      return '';
    }
  }

  static Future logoutController() async {

  }

  static Future getProfileController() async {}

  static Future patchProfileController() async {}
}
