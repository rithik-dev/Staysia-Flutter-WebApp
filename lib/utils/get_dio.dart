import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio getDioInstance() {
  return Dio(
    BaseOptions(
      baseUrl: 'https://staysia.herokuapp.com/',
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjNlNTQyN2NkMzUxMDhiNDc2NjUyMDhlYTA0YjhjYTZjODZkMDljOTMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZS10cmF2ZWwtZDEyNzYiLCJhdWQiOiJlLXRyYXZlbC1kMTI3NiIsImF1dGhfdGltZSI6MTYwNTcxMTI2NSwidXNlcl9pZCI6InBHUVZYQ0JGN2xWaGlOZmUxMDVWRTI0S3A3bzIiLCJzdWIiOiJwR1FWWENCRjdsVmhpTmZlMTA1VkUyNEtwN28yIiwiaWF0IjoxNjA1NzExMjY1LCJleHAiOjE2MDU3MTQ4NjUsImVtYWlsIjoic2hpdmFtdGhlZ3JlYXQuc3ZAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbInNoaXZhbXRoZWdyZWF0LnN2QGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.hz9B50sZqAampMoVH5ZlFmlw7V3IVTqbPRlr7KFqrUu0OejKYMx-dxe4twum19Vs-HtodpbH_4_yWka8BpBfbJV60_kZsdEERKokGDkKXx8P4MKau5dtcn0bc2cxpdvL22JS73phyB41IKBqbB17dss-_XFfbzBm0YDGxD8IRjT4NqTisnaVAp55BxBvajBD4KicvnYRgyx7Oty5a6IIgemuMKPAKmbaQB3JP5gPuqKyxCTfisHB9fKrkpN5GLHY-s2qqKGNdLGrwA8NsunEHZCaUxahEoAjtiyShxcPlp_JYH4W2UcCQZ9i3HxyASNm4eC0pbSG_KbjSDEGpukyEg',
        'X-Requested-With': 'XMLHttpRequest',
      },
      contentType: Headers.formUrlEncodedContentType,
    ),
  )..interceptors.add(PrettyDioLogger(requestBody: true));
}
