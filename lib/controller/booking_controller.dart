import 'package:dio/dio.dart';
import 'package:staysia_web/main.dart';
import 'package:staysia_web/models/booking.dart';
import 'package:staysia_web/utils/get_dio.dart';
import 'package:staysia_web/utils/routes.dart';

class BookingController {
  static final Dio _dio = getDioInstance();

  static Future<List<Booking>> getBookingsController() async {
    try {
      logger.d(getBookings);
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
