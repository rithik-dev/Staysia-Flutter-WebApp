import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio getDioInstance() {
  return Dio(
    BaseOptions(
      baseUrl: 'https://staysia.herokuapp.com/api/',
      headers: {
        // 'Authorization':
        // 'Bearer $idToken',
        // 'X-Requested-With': 'XMLHttpRequest',
      },
      contentType: Headers.formUrlEncodedContentType,
    ),
  )..interceptors.add(PrettyDioLogger(requestBody: true));
}
