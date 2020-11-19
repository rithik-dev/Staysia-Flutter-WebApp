import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staysia_web/components/custom_text_form_field.dart';
import 'package:staysia_web/controller/navigation_controller.dart';
import 'package:staysia_web/controller/user_controller.dart';
import 'package:staysia_web/main.dart';
import 'package:staysia_web/models/user.dart';
import 'package:staysia_web/utils/constants.dart';
import 'package:staysia_web/views/home_page.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  static const id = '/login';
  final String password, email;

  LoginPage({this.password = '', this.email = ''});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  bool isLoading = false;
  String _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = widget.email;
    _password = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Login\n\n",
                    textAlign: TextAlign.center,
                  ),
                  CustomTextFormField(
                    labelText: "Email",
                    defaultValue: widget.email,
                    icon: Icons.mail,
                    autofocus: true,
                    onChanged: (String value) {
                      _email = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty || value.trim() == "")
                        return 'Please Enter Your Email';
                      else if (!(value.contains("@") && value.contains(".")))
                        return "Invalid Email";
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  CustomTextFormField(
                    defaultValue: widget.password,
                    labelText: "Password",
                    icon: Icons.lock,
                    onChanged: (String value) {
                      _password = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty || value.trim() == "")
                        return 'Please Enter Your Password';
                      else if (value.length < 6)
                        return "Length should be greater than 5";
                      return null;
                    },
                  ),
                  FlatButton(
                    child: Text("LOGIN"),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        try {
                          ACCESS_TOKEN = await UserController.loginController(
                            email: _email?.trim(),
                            password: _password,
                          );
                          logger.d(ACCESS_TOKEN);

                          if (ACCESS_TOKEN == '') {
                            showSimpleNotification(
                              Text(
                                'An error occurred while logging in',
                                style: TextStyle(color: Colors.white),
                              ),
                              background: Colors.red,
                            );
                          } else {
                            final pref = await SharedPreferences.getInstance();
                            await pref.setString('jwt', ACCESS_TOKEN);
                            showSimpleNotification(
                              Text('Logged in successfully'),
                              background: Colors.green,
                            );
                            Provider.of<User>(context, listen: false)
                                .setLoggedInStatus(true);
                            await Navigator.pushNamedAndRemoveUntil(
                              context,
                              HomePage.id,
                              (route) => false,
                            );
                          }
                        } catch (e) {
                          showSimpleNotification(
                            Text(
                              'An error occurred while logging in',
                              style: TextStyle(color: Colors.white),
                            ),
                            background: Colors.red,
                          );
                        }
                      }
                    },
                  ),
                  // FlatButton(
                  //   child: Text("Register ?"),
                  //   onPressed: () {
                  //     Navigator.popAndPushNamed(
                  //         context, RegistrationScreen.id);
                  //   },
                  // )
                ],
              ),
            ),
            // isLoading ? LoadingScreen() : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
