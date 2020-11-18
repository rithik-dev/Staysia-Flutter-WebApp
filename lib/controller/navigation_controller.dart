import 'package:dio/dio.dart';
import 'package:staysia_web/models/get_citites.dart';
import 'package:staysia_web/utils/get_dio.dart';

class NavigationController {
  static final Dio _dio = getDioInstance();

  static Future<GetCities> getCitiesController() async {
    try {
      final res = await _dio.get("/api/");
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return GetCities.fromJson(res.data);
      } else {
        return null;
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }

  static Future getHotelsWithNameController({String tag}) async {}

  static Future searchHotelWithNameController() async {}

  static Future fuzzySearchController() async {}

  static Future fuzzyTagSearchController() async {}

  static Future getHotelByIdController({String hotelId}) async {}

  static Future getHotelRecommendationByIdController({String hotelId}) async {}
}
