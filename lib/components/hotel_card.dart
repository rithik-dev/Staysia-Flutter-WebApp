import 'package:flutter/material.dart';
import 'package:staysia_web/models/hotel.dart';

class HotelCard extends StatelessWidget {
  final Hotel hotel;

  const HotelCard(this.hotel);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
      ),
      child: Row(
        children: [
          Image.network(hotel.thumbnail),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(hotel.title),
              Text(hotel.city),
              Text(hotel.rating.toString()),
              Text('Rs ${hotel.price.currentPrice}'),
              Text(hotel.neighbourhood),
            ],
          ),
        ],
      ),
    );
  }
}
