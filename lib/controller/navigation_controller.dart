import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:staysia_web/models/detailed_hotel.dart';
import 'package:staysia_web/models/get_cities.dart';
import 'package:staysia_web/models/hotel.dart';
import 'package:staysia_web/utils/get_dio.dart';
import 'package:staysia_web/utils/routes.dart';

import '../main.dart';

class NavigationController {
  static final Dio _dio = getDioInstance();

  static Future<GetCities> getCitiesController() async {
    try {
      final res = await _dio.get(getCities);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return GetCities.fromJson(res.data as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  static Future<List<Hotel>> getHotelsWithTagController(
      {String cityName, @required String tag}) async {
    try {
      final res = await _dio.get(getHotelsWithTags + tag, queryParameters: {
        if (cityName != null) 'city': cityName,
      });
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return (res.data as List<dynamic>)
            .map((e) => Hotel.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<Hotel>();
      } else {
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  static Future<List<Hotel>> searchHotelWithNameController({
    @required String q,
    String city,
    String checkIn,
    String checkOut,
  }) async {
    try {
      final res = await _dio.get(searchHotelsWithName, queryParameters: {
        'q': q,
        if (city != null) 'city': city,
        if (checkIn != null) 'check_In': checkIn,
        if (checkOut != null) 'check_Out': checkOut,
      });
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return (res.data as List<dynamic>)
            .map((e) => Hotel.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<Hotel>();
      } else {
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  // static Future fuzzySearchController() async {}
  //
  // static Future fuzzyTagSearchController() async {}

  static Future<DetailedHotel> getHotelByIdController({@required String hotelId}) async {
    try {
      final res = await _dio.get(getHotelById + hotelId);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return DetailedHotel.fromJson(res.data as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  static Future<List<DetailedHotel>> getHotelRecommendationByIdController(
      {@required String hotelId}) async {
    try {
      final res = await _dio.get(
        getHotelRecommendationById.replaceAll('{hotelId}', hotelId),
      );
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return (res.data as List<dynamic>)
            .map((e) => DetailedHotel.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<DetailedHotel>();
      } else {
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
