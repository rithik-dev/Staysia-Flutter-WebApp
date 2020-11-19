import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staysia_web/controller/booking_controller.dart';
import 'package:staysia_web/controller/user_controller.dart';
import 'package:staysia_web/main.dart';
import 'package:staysia_web/models/booking.dart';
import 'package:staysia_web/models/user.dart';
import 'package:staysia_web/utils/constants.dart';
import 'package:staysia_web/utils/firebase_auth.dart';

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
              child: Text('test api'),
              onPressed: () async {
                try {
                  // await UserController.patchProfileController(
                  //   name: 'sv',
                  //   phone_number: '9988',
                  // );
                  print(Provider.of<User>(context, listen: false).isLoggedIn);
                  // logger.d(jwt);
                  // await BookingController.editBookingController(
                  //     booking: Booking.fromJson({
                  //   "status": "booked",
                  //   "bookingDetails": {
                  //     "bookingName": "string",
                  //     "guests": 1,
                  //     "room": {"roomType": 1},
                  //     "check_In": "dd/mm/yyyy",
                  //     "check_Out": "dd/mm/yyyy"
                  //   }
                  // }));
                } catch (e) {
                  logger.e(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
