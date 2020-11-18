import 'package:dio/dio.dart';
import 'package:staysia_web/models/booking.dart';
import 'package:staysia_web/utils/get_dio.dart';

class BookingController {
  static final Dio _dio = getDioInstance();

  static Future<List<Booking>> getBookingsController() async {
    try {
      final res = await _dio.get('/api/profile/bookings');
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return (res.data as List<Map<String, dynamic>>)
            .map((e) => Booking.fromJson(e))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
