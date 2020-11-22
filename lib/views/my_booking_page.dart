import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:staysia_web/components/booking_card.dart';
import 'package:staysia_web/components/custom_error_widget.dart';
import 'package:staysia_web/controller/booking_controller.dart';
import 'package:staysia_web/models/booking.dart';
import 'package:staysia_web/views/home_page.dart';

class MyBookingPage extends StatefulWidget {
  static const id = '/booking';

  MyBookingPage({Key key}) : super(key: key);

  @override
  _MyBookingPageState createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              padding: EdgeInsets.all(10),
              icon: Icon(
                Icons.home_outlined,
                size: 30,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomePage.id, (route) => false);
              },
            )
          ],
          title: Text(
            'STAYSIA',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              letterSpacing: 3,
            ),
          ),
        ),
        body: FutureBuilder(
            future: BookingController.getBookingsController(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.length == 0) {
                  return Column(
                    children: [
                      Lottie.asset('lottie/404.json'),
                      Text('No bookings found....',
                          style: Theme.of(context).textTheme.headline4)
                    ],
                  );
                } else if (snapshot.hasError) {
                  return CustomErrorWidget();
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return BookingCard(
                        booking: snapshot.data[index] as Booking,
                      );
                    },
                    itemCount: (snapshot.data as List).length,
                  );
                }
              } else {
                return Center(
                  child: SpinKitCircle(
                    color: Theme.of(context).accentColor,
                  ),
                );
              }
            }),
      ),
    );
  }
}
