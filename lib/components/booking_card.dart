import 'package:flutter/material.dart';
import 'package:staysia_web/models/booking.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;

  BookingCard({@required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(booking.title),
    );
  }
}
