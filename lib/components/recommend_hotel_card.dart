import 'package:flutter/material.dart';
import 'package:staysia_web/models/hotel.dart';
import 'package:staysia_web/views/hotel_details_page.dart';

class RecommendHotelCard extends StatelessWidget {
  final Hotel hotel;

  const RecommendHotelCard(this.hotel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          HotelDetailsPage.id,
          arguments: hotel.id,
        );
      },
      child: Container(
        width: 250,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
        ),
        child: Column(
          children: [
            Image.network(
              hotel.thumbnail,
              height: 150,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          hotel.neighbourhood,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          hotel.city,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rs ${hotel.price.currentPrice}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow[700]),
                            Text(
                              hotel.rating.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
