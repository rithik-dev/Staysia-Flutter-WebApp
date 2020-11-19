import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:staysia_web/models/get_citites.dart';
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

  static Future searchHotelWithNameController() async {
    try {
      final res = await _dio.get(searchHotelsWithName, queryParameters: {
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

  static Future getHotelByIdController({String hotelId}) async {}

  static Future getHotelRecommendationByIdController({String hotelId}) async {}
}
