import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:staysia_web/models/review.dart';
import 'package:staysia_web/utils/get_dio.dart';
import 'package:staysia_web/utils/routes.dart';

import '../main.dart';

class ReviewController {
  static final Dio _dio = getDioInstance();

  static Future<NewReviews> addReviewToHotelController(
      {@required String hotelId, @required Review review}) async {
    try {
      final res = await _dio.put(addReviewToHotel.replaceAll('{hotelId}',hotelId), data: review.toMap());
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
