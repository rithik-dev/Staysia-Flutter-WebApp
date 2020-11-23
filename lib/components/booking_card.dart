import 'package:flutter/material.dart';
import 'package:staysia_web/controller/booking_controller.dart';
import 'package:staysia_web/models/booking.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;

  BookingCard({@required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
        color: Colors.white,
      ),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.title,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    booking.status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    '  on ${booking.timestamp}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 15),
              ListTile(
                title: Text(
                  'Person Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  booking.bookingDetails.bookingName,
                  style: TextStyle(fontSize: 15),
                ),
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).accentColor,
                  size: 25,
                ),
              ),
              ListTile(
                title: Text(
                  'Number of Guests',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  booking.bookingDetails.guests.toString(),
                  style: TextStyle(fontSize: 15),
                ),
                leading: Icon(
                  Icons.group,
                  color: Theme.of(context).accentColor,
                  size: 25,
                ),
              ),
              ListTile(
                title: Text(
                  'Check In Time',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  booking.bookingDetails.checkIn,
                  style: TextStyle(fontSize: 15),
                ),
                leading: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 25,
                ),
              ),
              ListTile(
                title: Text(
                  'Check Out Time',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  booking.bookingDetails.checkOut,
                  style: TextStyle(fontSize: 15),
                ),
                leading: Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 25,
                ),
              ),
              ListTile(
                title: Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text('Rs ${booking.price}'),
                leading: Icon(
                  Icons.money,
                  color: Colors.green,
                  size: 25,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: ShapeDecoration(
                shape: StadiumBorder(),
                color: Theme.of(context).accentColor,
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      try {
                        // ignore: omit_local_variable_types
                        bool deleted =
                            await BookingController.deleteBookingController(
                                bookingId: booking.bookingId);
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      // await BookingController.editBookingController(bookingId: booking.bookingId,booking: );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
