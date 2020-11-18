import 'package:dio/dio.dart';

Dio getDioInstance() {
  return Dio(BaseOptions(baseUrl: 'https://staysia.herokuapp.com/'));
}
