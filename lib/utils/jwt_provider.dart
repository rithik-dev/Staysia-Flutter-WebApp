import 'package:flutter/cupertino.dart';

class JwtProvider extends ChangeNotifier {
  String token;

  JwtProvider({
    @required this.token,
  });

  factory JwtProvider.fromString(String token) {
    return JwtProvider(token: token);
  }

  factory JwtProvider.fromJson(Map json) {
    return JwtProvider(
      token: json['token'] as String,
    );
  }

  @override
  String toString() {
    return 'Jwt{value: $token}';
  }

  void updateTokenInProvider({String token}) {
    this.token = token;
    notifyListeners();
  }
}
