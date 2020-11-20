import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staysia_web/controller/user_controller.dart';
import 'package:staysia_web/main.dart';
import 'package:staysia_web/models/user.dart';
import 'package:staysia_web/utils/constants.dart';
import 'package:staysia_web/views/home_page.dart';

import 'google_sign_in_button.dart';

class AuthDialog extends StatefulWidget {
  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  bool isLoading = false;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            color: Theme.of(context).primaryColor,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'STAYSIA',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline1.color,
                        fontSize: 24,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      bottom: 8,
                    ),
                    child: Text(
                      'Email address',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle2.color,
                        fontSize: 18,
                        // fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        // letterSpacing: 3,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20,
                    ),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty || value.trim() == '') {
                          return 'Please Enter Your Email';
                        } else if (!(value.contains('@') &&
                            value.contains('.'))) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blueGrey[800],
                            width: 3,
                          ),
                        ),
                        filled: true,
                        hintStyle: TextStyle(
                          color: Colors.blueGrey[300],
                        ),
                        hintText: 'Email',
                        fillColor: Colors.white,
                        errorStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      bottom: 8,
                    ),
                    child: Text(
                      'Password',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle2.color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        // letterSpacing: 3,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20,
                    ),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty || value.trim() == '') {
                          return 'Please Enter Your Password';
                        } else if (value.length < 6) {
                          return 'Length should be greater than 5';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      autofocus: false,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blueGrey[800],
                            width: 3,
                          ),
                        ),
                        filled: true,
                        hintStyle: TextStyle(
                          color: Colors.blueGrey[300],
                        ),
                        hintText: 'Password',
                        fillColor: Colors.white,
                        errorStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: double.maxFinite,
                            child: FlatButton(
                              color: Colors.blueGrey[800],
                              hoverColor: Colors.blueGrey[900],
                              highlightColor: Colors.black,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  try {
                                    ACCESS_TOKEN =
                                        await UserController.loginController(
                                      email: _email?.trim(),
                                      password: _password,
                                    );

                                    if (ACCESS_TOKEN == '') {
                                      logger.d('here lol');

                                      showSimpleNotification(
                                        Text(
                                          'An error occurred while logging in',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        background: Colors.red,
                                      );
                                    } else {
                                      final pref =
                                          await SharedPreferences.getInstance();
                                      await pref.setString('jwt', ACCESS_TOKEN);
                                      logger.d('here');
                                      showSimpleNotification(
                                        Text('Logged in successfully'),
                                        background: Colors.green,
                                      );
                                      Provider.of<User>(context, listen: false)
                                          .setLoggedInStatus(true);
                                      logger.d(Provider.of<User>(context,
                                          listen: false));
                                      Navigator.pop(context);
                                    }
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
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 15.0,
                                  bottom: 15.0,
                                ),
                                child: isLoading
                                    ? SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        'Log in',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: double.maxFinite,
                            child: FlatButton(
                              color: Colors.blueGrey[800],
                              hoverColor: Colors.blueGrey[900],
                              highlightColor: Colors.black,
                              onPressed: () async {}
                              //   setState(() {
                              //     textFocusNodeEmail.unfocus();
                              //     textFocusNodePassword.unfocus();
                              //   });
                              //   if (_validateEmail(textControllerEmail.text) ==
                              //           null &&
                              //       _validatePassword(
                              //               textControllerPassword.text) ==
                              //           null) {
                              //     setState(() {
                              //       _isRegistering = true;
                              //     });
                              //     // await registerWithEmailPassword(
                              //     //         textControllerEmail.text,
                              //     //         textControllerPassword.text)
                              //     //     .then((result) {
                              //     //   if (result != null) {
                              //     //     setState(() {
                              //     //       loginStatus =
                              //     //           'You have registered successfully';
                              //     //       loginStringColor = Colors.green;
                              //     //     });
                              //     //     print(result);
                              //     //   }
                              //     // }).catchError((error) {
                              //     //   print('Registration Error: $error');
                              //     //   setState(() {
                              //     //     loginStatus =
                              //     //         'Error occured while registering';
                              //     //     loginStringColor = Colors.red;
                              //     //   });
                              //     // });
                              //   } else {
                              //     setState(() {
                              //       loginStatus = 'Please enter email & password';
                              //       loginStringColor = Colors.red;
                              //     });
                              //   }
                              //   setState(() {
                              //     _isRegistering = false;
                              //
                              //     textControllerEmail.text = '';
                              //     textControllerPassword.text = '';
                              //     _isEditingEmail = false;
                              //     _isEditingPassword = false;
                              //   });
                              // }
                              ,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 15.0,
                                  bottom: 15.0,
                                ),
                                child:
                                    // _isRegistering
                                    //     ? SizedBox(
                                    //         height: 16,
                                    //         width: 16,
                                    //         child: CircularProgressIndicator(
                                    //           strokeWidth: 2,
                                    //           valueColor:
                                    //               AlwaysStoppedAnimation<Color>(
                                    //             Colors.white,
                                    //           ),
                                    //         ),
                                    //       )
                                    //     :
                                    Text(
                                  'Sign up',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // loginStatus != null
                  //     ? Center(
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(
                  //             bottom: 20.0,
                  //           ),
                  //           child: Text(
                  //             loginStatus,
                  //             style: TextStyle(
                  //               color: loginStringColor,
                  //               fontSize: 14,
                  //               // letterSpacing: 3,
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     : Container(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40.0,
                      right: 40.0,
                    ),
                    child: Container(
                      height: 1,
                      width: double.maxFinite,
                      color: Colors.blueGrey[200],
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(child: GoogleButton()),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'By proceeding, you agree to our Terms of Use and confirm you have read our Privacy Policy.',
                      maxLines: 2,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle2.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        // letterSpacing: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
