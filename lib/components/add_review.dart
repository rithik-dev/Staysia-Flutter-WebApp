import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:staysia_web/controller/review_controller.dart';

import 'package:staysia_web/models/detailed_hotel.dart';
import 'package:staysia_web/models/review.dart';

import '../main.dart';

class AddReview extends StatefulWidget {
  final int hotelId;
  AddReview({Key key,this.hotelId}) : super(key: key);
  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String _title;

  // ignore: omit_local_variable_types
  String _review;
  @override
  Widget build(BuildContext context) {
    return                           Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      width: 300,
      child: Form(
        child: Column(
          children: [
            Text('Add a Review'),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                bottom: 8,
              ),
              child: Text(
                'Title',
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
                  if (value.isEmpty ||
                      value.trim() == '') {
                    return 'Please enter title';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                obscureText: false,
                autofocus: false,
                initialValue:'My Review',
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blueGrey[800],
                      width: 3,
                    ),
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.blueGrey[300],
                  ),
                  hintText: 'Title',
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
                'Title',
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
                  if (value.isEmpty ||
                      value.trim() == '') {
                    return 'Please enter your review';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                obscureText: false,
                autofocus: false,
                maxLines: 5,
                initialValue:'My Review',
                onChanged: (value) {
                  setState(() {
                    _review = value;
                  });
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blueGrey[800],
                      width: 3,
                    ),
                  ),
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.blueGrey[300],
                  ),
                  hintText: 'Review',
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
              padding: const EdgeInsets.all(20.0),
              child: Flexible(
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
                        if (_review == null &&
                            _title == null) {
                          toast(
                              'Please Change at least one field');
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            // ignore: omit_local_variable_types
                             NewReviews newUser= await ReviewController
                                .addReviewToHotelController(
                              hotelId: widget.hotelId,
                               // review: Review()
                            );
                            if (newUser == null) {
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
                        'Add Review',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )
    ;
  }
}