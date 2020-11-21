import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staysia_web/main.dart';
import 'package:staysia_web/models/booking.dart';
import 'package:staysia_web/utils/Jwt.dart';
import 'package:staysia_web/utils/get_dio.dart';
import 'package:staysia_web/utils/routes.dart';

class BookingController {


  static Future<Booking> addNewBookingController(
      {@required String hotelId, @required Booking booking}) async {
    try {
      // ignore: omit_local_variable_types
      Dio _dio = Dio(
        BaseOptions(
          baseUrl: 'https://staysia.herokuapp.com/api/',
          headers: {
            'Authorization': 'Bearer ${Get.find<Jwt>().token.value}',
            // 'X-Requested-With': 'XMLHttpRequest',
          },
          contentType: Headers.formUrlEncodedContentType,
        ),
      )..interceptors.addAll([
        PrettyDioLogger(requestBody: true, requestHeader: true),
        InterceptorsWrapper(
          onError: (DioError error) async {
            if (error.response == null) {
              // ignore: avoid_print
              print(error);
            } else if (error.response.statusCode == 401) {
              Get.find<Jwt>()
                  .setToken(null);
              final preferences = await SharedPreferences.getInstance();
              await preferences.remove('jwt');
              //TODO: push to login page
            }
          },
        ),
      ]);
      final res =
          await _dio.put(addNewBooking + hotelId, data: booking.toMap());
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return Booking.fromJson(res.data as Map<String, dynamic>);
      } else {
        logger.w(res);
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  static Future<bool> deleteBookingController(
      {@required String bookingId}) async {
    try {
      // ignore: omit_local_variable_types
      Dio _dio = Dio(
        BaseOptions(
          baseUrl: 'https://staysia.herokuapp.com/api/',
          headers: {
            'Authorization': 'Bearer ${Get.find<Jwt>().token.value}',
            // 'X-Requested-With': 'XMLHttpRequest',
          },
          contentType: Headers.formUrlEncodedContentType,
        ),
      )..interceptors.addAll([
        PrettyDioLogger(requestBody: true, requestHeader: true),
        InterceptorsWrapper(
          onError: (DioError error) async {
            if (error.response == null) {
              // ignore: avoid_print
              print(error);
            } else if (error.response.statusCode == 401) {
              Get.find<Jwt>()
                  .setToken(null);
              final preferences = await SharedPreferences.getInstance();
              await preferences.remove('jwt');
              //TODO: push to login page
            }
          },
        ),
      ]);
      final res = await _dio.delete(deleteBookingById + bookingId);
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

  static Future<Booking> editBookingController(
      {String bookingId, Booking booking}) async {
    try {
      // ignore: omit_local_variable_types
      Dio _dio = Dio(
        BaseOptions(
          baseUrl: 'https://staysia.herokuapp.com/api/',
          headers: {
            'Authorization': 'Bearer ${Get.find<Jwt>().token.value}',
            // 'X-Requested-With': 'XMLHttpRequest',
          },
          contentType: Headers.formUrlEncodedContentType,
        ),
      )..interceptors.addAll([
        PrettyDioLogger(requestBody: true, requestHeader: true),
        InterceptorsWrapper(
          onError: (DioError error) async {
            if (error.response == null) {
              // ignore: avoid_print
              print(error);
            } else if (error.response.statusCode == 401) {
              Get.find<Jwt>()
                  .setToken(null);
              final preferences = await SharedPreferences.getInstance();
              await preferences.remove('jwt');
              //TODO: push to login page
            }
          },
        ),
      ]);
      final res =
          await _dio.patch(editBookingById + bookingId, data: booking.toMap());
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return Booking.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  static Future<List<Booking>> getBookingsController() async {
    try {
      // ignore: omit_local_variable_types
      Dio _dio = Dio(
        BaseOptions(
          baseUrl: 'https://staysia.herokuapp.com/api/',
          headers: {
            'Authorization': 'Bearer ${Get.find<Jwt>().token.value}',
            // 'X-Requested-With': 'XMLHttpRequest',
          },
          contentType: Headers.formUrlEncodedContentType,
        ),
      )..interceptors.addAll([
        PrettyDioLogger(requestBody: true, requestHeader: true),
        InterceptorsWrapper(
          onError: (DioError error) async {
            if (error.response == null) {
              // ignore: avoid_print
              print(error);
            } else if (error.response.statusCode == 401) {
              Get.find<Jwt>()
                  .setToken(null);
              final preferences = await SharedPreferences.getInstance();
              await preferences.remove('jwt');
              //TODO: push to login page
            }
          },
        ),
      ]);
      final res = await _dio.get(getBookings);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return (res.data as List<dynamic>)
            .map((e) => Booking.fromJson(e))
            .toList()
            .cast<Booking>();
      } else {
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
