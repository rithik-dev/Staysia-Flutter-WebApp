import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:staysia_web/models/user.dart';
import 'package:staysia_web/utils/get_dio.dart';
import 'package:staysia_web/utils/routes.dart';

import '../main.dart';

class UserController {
  static final Dio _dio = getDioInstance();

  static Future<String> signupController(
      {@required String name,@required String email,@required String password,@required String phone_number}) async {
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

  static Future<String> googleSignupController({@required String idToken}) async {
    try {
      final res = await _dio.put(googleSignup);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(res.data);
        return (res.data['jwt'] as String);
      } else {
        return '';
      }
    } catch (e) {
      logger.e(e);
      return '';
    }
  }

  static Future<String> loginController({
    @required String email,
    @required String password,
  }) async {
    try {
      final res =
          await _dio.post(login, data: {'password': password, 'email': email});
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return (res.data['idToken'] as String);
      } else {
        logger.w(res);
        return '';
      }
    } catch (e) {
      logger.e(e);
      return '';
    }
  }

  static Future<bool> logoutController() async {
    try {
      final res = await _dio.get(logout);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  static Future<User> getProfileController() async {
    try {
      final res = await _dio.get(getProfile);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return User(
            name: res.data['name'] as String,
            email: res.data['email'] as String,
            phone_number: res.data['phone_number'] as String);
      } else {
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  static Future<User> patchProfileController(
      {@required String name, @required String phone_number}) async {
    try {
      final res = await _dio.patch(patchProfile,
          data: {'name': name, 'phone_number': phone_number});
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return User(
            name: res.data['name'] as String,
            email: res.data['email'] as String,
            phone_number: res.data['phone_number'] as String);
      } else {
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
