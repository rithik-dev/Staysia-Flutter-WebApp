import 'package:dio/dio.dart';
import 'package:staysia_web/utils/get_dio.dart';

class NavigationController {

  final Dio _dio = getDioInstance();

  static Future getCitiesController() async {}

  static Future getHotelsWithNameController({String tag}) async {}

  static Future searchHotelWithNameController() async {}

  static Future fuzzySearchController() async {}

  static Future fuzzyTagSearchController() async {}

  static Future getHotelByIdController({String hotelId}) async {}

  static Future getHotelRecommendationByIdController({String hotelId}) async {}
}
