import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  String name;
  String email;
  String phone;

  User({
    @required this.name,
    @required this.email,
    @required this.phone,
  });

  factory User.fromJson(Map json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // ignore: unnecessary_this
      'name': this.name,
      // ignore: unnecessary_this
      'email': this.email,
      // ignore: unnecessary_this
      'phone': this.phone,
    };
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, phone: $phone}';
  }

  void updateUserInProvider(User user) {
    // ignore: unnecessary_this
    this.name = user.name;
    // ignore: unnecessary_this
    this.email = user.email;
    // ignore: unnecessary_this
    this.phone = user.phone;

    notifyListeners();
  }
}
