import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staysia_web/utils/constants.dart';

Dio getDioInstance({bool removeBaseHeaders = false}) {
  if (removeBaseHeaders) {
    return Dio(
      BaseOptions(
        baseUrl: 'https://staysia.herokuapp.com/api/',
        headers: {
          'Authorization': 'Bearer $ACCESS_TOKEN',
        },
      ),
    )..interceptors.addAll([
        PrettyDioLogger(requestBody: true),
        InterceptorsWrapper(
          onError: (DioError error) async {
            if (error.response == null) {
              // ignore: avoid_print
              print(error);
            } else if (error.response.statusCode == 401) {
              ACCESS_TOKEN = null;
              final preferences = await SharedPreferences.getInstance();
              await preferences.remove('jwt');
              //TODO: push to login page
            }
          },
        ),
      ]);
  }
  return Dio(
    BaseOptions(
      baseUrl: 'https://staysia.herokuapp.com/api/',
      headers: {
        'Authorization': 'Bearer $ACCESS_TOKEN',
        'X-Requested-With': 'XMLHttpRequest',
      },
      contentType: Headers.formUrlEncodedContentType,
    ),
  )..interceptors.addAll([
      PrettyDioLogger(requestBody: true),
      InterceptorsWrapper(
        onError: (DioError error) async {
          if (error.response == null) {
            // ignore: avoid_print
            print(error);
          } else if (error.response.statusCode == 401) {
            ACCESS_TOKEN = null;
            final preferences = await SharedPreferences.getInstance();
            await preferences.remove('jwt');
            //TODO: push to login page
          }
        },
      ),
    ]);
}
