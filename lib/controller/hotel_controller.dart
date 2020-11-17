import 'package:dio/dio.dart';

class HotelController{
  Dio dio = Dio(
    BaseOptions(baseUrl: 'https://staysia.herokuapp.com/')
  );
}