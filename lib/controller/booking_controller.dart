import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:staysia_web/main.dart';
import 'package:staysia_web/models/booking.dart';
import 'package:staysia_web/utils/get_dio.dart';
import 'package:staysia_web/utils/routes.dart';

class BookingController {
  static final Dio _dio = getDioInstance();

  static Future addNewBookingController({@required String hotelId}) async {
    //   {
    //     "status": "booked",
    //   "bookingDetails": {
    //   "bookingName": "string",
    //   "guests": 1,
    //   "room": {
    //   "roomType": 1
    //   },
    //   "check_In": "dd/mm/yyyy",
    //   "check_Out": "dd/mm/yyyy"
    //   }
    // }

    //   {
    //     "bookingDetails": {
    //   "bookingName": "string",
    //   "check_In": "string",
    //   "check_Out": "string",
    //   "guests": 0,
    //   "room": {
    //   "roomType": 0
    //   }
    //   },
    //   "bookingId": "string",
    //   "hotelId": "string",
    //   "price": 0,
    //   "status": "booked",
    //   "timestamp": "string",
    //   "title": "string"
    // }
  }

  static Future<bool> deleteBookingController(
      {@required String bookingId}) async {
    try {
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
      final res = await _dio.patch(editBookingById + bookingId,
          data: Booking().toJson(booking));
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
