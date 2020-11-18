import 'package:flutter/material.dart';
import 'package:staysia_web/controller/booking_controller.dart';
import 'package:staysia_web/controller/navigation_controller.dart';

class LoginPage extends StatefulWidget {
  final String email, password;

  const LoginPage({this.email = '', this.password = ''});

  static const id = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text('logs'),
            FlatButton(
              child: Text("test api"),
              onPressed: () {
                BookingController.getBookingsController();
              },
            ),
          ],
        ),
      ),
    );
  }
}
