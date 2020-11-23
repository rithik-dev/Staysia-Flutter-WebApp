import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:staysia_web/controller/booking_controller.dart';
import 'package:staysia_web/models/booking.dart';

import '../main.dart';

class BookingDialog extends StatefulWidget {
  final String status;
  final BookingDetails bookingDetails;
  final String bookingId;
  final int hotelId;

  BookingDialog(
      {Key key,
      this.hotelId,
      this.bookingId,
      @required this.bookingDetails,
      @required this.status})
      : super(key: key);

  @override
  _BookingDialogState createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  int noOfGuests;

  // ignore: omit_local_variable_types
  String bookingName;

  Future<Booking> addBooking() async {
    // ignore: omit_local_variable_types
    return await BookingController.addNewBookingController(
        hotelId: widget.hotelId.toString(), booking: widget.bookingDetails);
  }

  Future<Booking> editBooking() async {
    // ignore: omit_local_variable_types
    return await BookingController.editBookingController(
        booking: widget.bookingDetails, bookingId: widget.bookingId);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          width: 400,
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(16.0),
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
                    'Name',
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
                        return 'Please Enter Your name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                    autofocus: false,
                    // initialValue: Provider.of<User>(context).name,
                    onChanged: (value) {
                      setState(() {
                        // noOfGuests = value;
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
                      hintText: 'Name',
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
                    'Phone Number',
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
                        return 'Please Enter Your number';
                      } else if (value.length < 6) {
                        return 'Length should be greater than 5';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                    autofocus: false,
                    // initialValue: Provider.of<User>(context).phone_number,
                    onChanged: (value) {
                      setState(() {
                        bookingName = value;
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
                      hintText: 'Phone Number',
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
                            disabledColor: Colors.blueGrey[800],
                            onPressed: isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState.validate()) {
                                      if (noOfGuests == null &&
                                          bookingName == null) {
                                        toast(
                                            'Please Change at least one field');
                                      } else {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        try {
                                          // ignore: omit_local_variable_types
                                          Booking booking =
                                              widget.bookingId != null
                                                  ? await addBooking()
                                                  : await editBooking();

                                          if (booking == null) {
                                            logger.d('here lol');
                                            setState(() {
                                              isLoading = false;
                                            });
                                            showSimpleNotification(
                                              Text(
                                                'An error occurred while editing profile',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              background: Colors.red,
                                            );
                                          } else {
                                            logger.d('here');
                                            showSimpleNotification(
                                              Text(
                                                  'Profile Updated successfully'),
                                              background: Colors.green,
                                            );

                                            setState(() {
                                              isLoading = false;
                                            });

                                            Navigator.pop(context);
                                          }
                                        } catch (e) {
                                          logger.e(e);
                                          showSimpleNotification(
                                            Text(
                                              'An error occurred while editing profile',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            background: Colors.red,
                                          );
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
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
                                      'Edit Profile',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
