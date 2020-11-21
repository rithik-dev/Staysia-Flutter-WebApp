import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staysia_web/models/review.dart';
import 'package:staysia_web/utils/Jwt.dart';
import 'package:staysia_web/utils/get_dio.dart';
import 'package:staysia_web/utils/routes.dart';

import '../main.dart';

class ReviewController {
  static final Dio _dio = getDioInstance();

  static Future<NewReviews> addReviewToHotelController(
      {@required String hotelId, @required Review review}) async {
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
                Get.find<Jwt>().setToken(null);
                final preferences = await SharedPreferences.getInstance();
                await preferences.remove('jwt');
                //TODO: push to login page
              }
            },
          ),
        ]);
      final res = await _dio.put(
          addReviewToHotel.replaceAll('{hotelId}', hotelId),
          data: review.toMap());
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return NewReviews.fromJson(res.data as Map<String, dynamic>);
      } else {
        logger.w(res);
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
