import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String email,password;
  const LoginPage({this.email = '',this.password = ''});
  static const id = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('logs'),
    );
  }
}