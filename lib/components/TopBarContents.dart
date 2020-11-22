import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staysia_web/components/auth_dialog.dart';
import 'package:staysia_web/components/edit_profile.dart';
import 'package:staysia_web/controller/user_controller.dart';
import 'package:staysia_web/models/user.dart';
import 'package:staysia_web/utils/Jwt.dart';
import 'package:staysia_web/views/my_booking_page.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;

  TopBarContents(this.opacity);

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List<bool> _isHovering = [false, false, false, false, false];

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(widget.opacity),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'STAYSIA',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                letterSpacing: 3,
              ),
            ),
            // Row(
            //   children: [
            //     InkWell(
            //       onHover: (value) {
            //         setState(() {
            //           value ? _isHovering[0] = true : _isHovering[0] = false;
            //         });
            //       },
            //       onTap: () {},
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Text(
            //             'Discover',
            //             style: TextStyle(
            //               color: _isHovering[0]
            //                   ? Theme.of(context).hintColor
            //                   : Theme.of(context).accentColor,
            //             ),
            //           ),
            //           SizedBox(height: 5),
            //           Visibility(
            //             maintainAnimation: true,
            //             maintainState: true,
            //             maintainSize: true,
            //             visible: _isHovering[0],
            //             child: Container(
            //               height: 2,
            //               width: 20,
            //               color: Theme.of(context).accentColor,
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(
            //       width: 50,
            //     ),
            //     InkWell(
            //       onHover: (value) {
            //         setState(() {
            //           value ? _isHovering[1] = true : _isHovering[1] = false;
            //         });
            //       },
            //       onTap: () {},
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Text(
            //             'Contact Us',
            //             style: TextStyle(
            //               color: _isHovering[1]
            //                   ? Theme.of(context).hintColor
            //                   : Theme.of(context).accentColor,
            //             ),
            //           ),
            //           SizedBox(height: 5),
            //           Visibility(
            //             maintainAnimation: true,
            //             maintainState: true,
            //             maintainSize: true,
            //             visible: _isHovering[1],
            //             child: Container(
            //               height: 2,
            //               width: 20,
            //               color: Theme.of(context).hintColor,
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            InkWell(
              onHover: (value) {
                setState(() {
                  value ? _isHovering[2] = true : _isHovering[2] = false;
                });
              },
              onTap: !Provider.of<User>(context).isLoggedIn
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) => AuthDialog(),
                      );
                    }
                  : null,
              child: !Provider.of<User>(context).isLoggedIn
                  ? Text(
                      'Sign in',
                      style: TextStyle(
                        color: _isHovering[2]
                            ? Theme.of(context).hintColor
                            : Theme.of(context).accentColor,
                      ),
                    )
                  : Row(
                      children: [
                        Chip(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                          ),
                          backgroundColor: Theme.of(context).accentColor,
                          label: Row(
                            children: [
                              CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 30,
                                    color: Theme.of(context).accentColor,
                                  )),
                              SizedBox(width: 5),
                              Text(
                                Provider.of<User>(context).name,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                            onHover: (value) {
                              setState(() {
                                value
                                    ? _isHovering[4] = true
                                    : _isHovering[4] = false;
                              });
                            },
                            child: Provider.of<User>(context).isLoggedIn
                                ? FlatButton(
                                    color: Theme.of(context).accentColor,
                                    hoverColor: Theme.of(context).hintColor,
                                    highlightColor: Theme.of(context).hintColor,
                                    shape: StadiumBorder(),
                                    onPressed:
                                        Provider.of<User>(context).isLoggedIn
                                            ? () {
                                                Navigator.pushNamed(
                                                    context, MyBookingPage.id);
                                              }
                                            : null,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                      ),
                                      child: Text(
                                        'My Bookings',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox()),
                        SizedBox(width: 10),
                        InkWell(
                            onHover: (value) {
                              setState(() {
                                value
                                    ? _isHovering[3] = true
                                    : _isHovering[3] = false;
                              });
                            },
                            child: Provider.of<User>(context).isLoggedIn
                                ? FlatButton(
                                    color: Theme.of(context).accentColor,
                                    hoverColor: Theme.of(context).hintColor,
                                    highlightColor: Theme.of(context).hintColor,
                                    shape: StadiumBorder(),
                                    onPressed:
                                        Provider.of<User>(context).isLoggedIn
                                            ? () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      EditProfile(),
                                                );
                                              }
                                            : null,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                      ),
                                      child: Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox()),
                        SizedBox(width: 10),
                        FlatButton(
                          color: Theme.of(context).accentColor,
                          hoverColor: Theme.of(context).hintColor,
                          highlightColor: Theme.of(context).hintColor,
                          onPressed: _isProcessing
                              ? null
                              : () async {
                                  setState(() {
                                    _isProcessing = true;
                                  });
                                  // ignore: omit_local_variable_types
                                  bool result =
                                      await UserController.logoutController();
                                  if (result) {
                                    Provider.of<User>(context, listen: false)
                                        .setLoggedInStatus(false);
                                    // ignore: omit_local_variable_types
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    await pref.remove('jwt');
                                    Get.find<Jwt>().setToken('');
                                    showSimpleNotification(
                                      Text(
                                        'Successfully Logged out!',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      background: Colors.green,
                                    );
                                  } else {
                                    showSimpleNotification(
                                      Text(
                                        'An error occurred while logging out',
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
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: _isProcessing
                                ? SpinKitCircle(
          color: Theme.of(context).accentColor,
        )
                                : Text(
                                    'Sign out',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
