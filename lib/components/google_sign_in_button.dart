import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:staysia_web/controller/user_controller.dart';
import 'package:staysia_web/main.dart';
import 'package:staysia_web/models/user.dart';
import 'package:staysia_web/utils/firebase_auth.dart';
import 'package:staysia_web/utils/Jwt.dart';

class GoogleButton extends StatefulWidget {
  final bool disableOnTap;

  GoogleButton({@required this.disableOnTap});

  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).accentColor, width: 1),
        ),
        color: Colors.white,
      ),
      child: OutlineButton(
        highlightColor: Colors.blueGrey[100],
        splashColor: Colors.blueGrey[200],
        onPressed: widget.disableOnTap
            ? null
            : () async {
                setState(() {
                  _isProcessing = true;
                });
                // ignore: omit_local_variable_types
                try {
                  // ignore: omit_local_variable_types
                  Map jwt = await FirebaseAuthService.signInWithGoogle();
                  logger.d(jwt);
                  // ignore: omit_local_variable_types
                  String result = await UserController.googleSignupController(
                      idToken: jwt['idToken'] as String);
                  Get.find<Jwt>().setToken(result);
                  Provider.of<User>(context, listen: false)
                      .updateUserInProvider(User(
                    name: jwt['name'] as String,
                    phone_number: jwt['phone_number'] as String,
                    email: jwt['email'] as String,
                  ));
                  Provider.of<User>(context, listen: false)
                      .setLoggedInStatus(true);
                  showSimpleNotification(
                    Text(
                      'Logged in!!!',
                      style: TextStyle(color: Colors.white),
                    ),
                    background: Colors.green,
                  );
                } catch (e) {
                  logger.e(e);
                  showSimpleNotification(
                    Text(
                      'An error occurred while logging in',
                      style: TextStyle(color: Colors.white),
                    ),
                    background: Colors.red,
                  );
                }
                setState(() {
                  _isProcessing = false;
                });
              },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Theme.of(context).accentColor, width: 3),
        ),
        highlightElevation: 0,
        // borderSide: BorderSide(color: Colors.blueGrey, width: 3),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: _isProcessing
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).accentColor,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage('images/google_logo.png'),
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
