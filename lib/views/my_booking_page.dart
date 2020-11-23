import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:staysia_web/components/NoData.dart';
import 'package:staysia_web/components/TopBarContents.dart';
import 'package:staysia_web/components/booking_card.dart';
import 'package:staysia_web/components/custom_error_widget.dart';
import 'package:staysia_web/components/explore_drawer.dart';
import 'package:staysia_web/components/responsive_widget.dart';
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
  Future<List<Booking>> myBookings;

  List<Booking> bookings;

  void deleteBooking(String bookingId) {
    var _newBookings = <Booking>[];
    for (var booking in bookings) {
      if (booking.bookingId != bookingId) _newBookings.add(booking);
      else print("not adding ${booking.bookingId}");
    }


    setState(() {
      bookings = _newBookings;
    });

    print(bookings);
  }

  @override
  void initState() {
    myBookings = BookingController.getBookingsController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context)
            ? PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 1000),
                child: TopBarContents(),
              )
            : AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                automaticallyImplyLeading: true,
                elevation: 0,
                title: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomePage.id, (route) => false);
                      },
                      child: Text(
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
                  ],
                ),
              ),
        drawer: ExploreDrawer(),
        body: FutureBuilder(
            future: myBookings,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.length == 0) {
                  return NoData(message: "You don't have any bookings");
                } else if (snapshot.hasError) {
                  return CustomErrorWidget(
                    message: 'Failed to fetch bookings....',
                  );
                } else {
                  return FutureBuilder<List<Booking>>(
                    future: myBookings,
                    builder: (context, snapshot) {
                      bookings = snapshot.data;
                      if (snapshot.hasData) {
                        print("in snapshot");
                        print(bookings);
                        return SingleChildScrollView(
                          child: Wrap(
                            children: bookings
                                .map((e) => BookingCard(
                                    booking: e, deleteCallback: deleteBooking))
                                .toList(),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
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
