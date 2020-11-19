import 'package:flutter/material.dart';
import 'package:staysia_web/components/city_card.dart';
import 'package:staysia_web/components/custom_error_widget.dart';
import 'package:staysia_web/controller/booking_controller.dart';
import 'package:staysia_web/controller/navigation_controller.dart';
import 'package:staysia_web/controller/review_controller.dart';
import 'package:staysia_web/main.dart';
import 'package:staysia_web/models/booking.dart';
import 'package:staysia_web/models/get_citites.dart';
import 'package:staysia_web/models/review.dart';

class HomePage extends StatelessWidget {
  static const id = '/';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Staysia'),
        ),
        body: ListView(
          children: [
            FutureBuilder<GetCities>(
              future: NavigationController.getCitiesController(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 300,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CityCard(city: snapshot.data.cities[index]);
                      },
                      itemCount: snapshot.data.cities.length,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return CustomErrorWidget();
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            FlatButton(
              child: Text('click'),
              onPressed: () async {
                final a = await BookingController.addNewBookingController(
                  hotelId: '424978',
                  booking: Booking.fromJson(
                    {
                      "status": "booked",
                      "bookingDetails": {
                        "bookingName": "Deluxe Double Room, 1 Double Bed",
                        "guests": 1,
                        "room": {"roomType": 1},
                        "check_In": "20/11/2020",
                        "check_Out": "22/11/2020"
                      }
                    },
                  ),
                );
                logger.d(a);
              },
            )
          ],
        ),
      ),
    );
  }
}
