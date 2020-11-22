import 'package:flutter/material.dart';
import 'package:staysia_web/components/recommend_hotel_card.dart';
import 'package:staysia_web/components/hotel_card.dart';
import 'package:staysia_web/controller/navigation_controller.dart';
import 'package:staysia_web/models/detailed_hotel.dart';
import 'package:staysia_web/models/hotel.dart';

class HotelDetailsPage extends StatelessWidget {
  static const id = 'hotel_details_page';
  final int hotelId;

  const HotelDetailsPage({this.hotelId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            FutureBuilder<DetailedHotel>(
              future: NavigationController.getHotelByIdController(
                hotelId: hotelId.toString(),
              ),
              builder: (context, snapshot) {
                final hotel = snapshot.data;
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            hotel.mainImage,
                            width: 400,
                            fit: BoxFit.cover,
                            height: 350,
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                ListTile(
                                  title: Text(
                                    hotel.title,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    hotel.description,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  isThreeLine: true,
                                  leading: Icon(
                                    Icons.location_city,
                                    color: Theme.of(context).accentColor,
                                    size: 25,
                                  ),
                                ),
                                SizedBox(height: 15),
                                ListTile(
                                  title: Text(
                                    'Address',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    hotel.address,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  leading: Icon(
                                    Icons.location_on_rounded,
                                    color: Theme.of(context).accentColor,
                                    size: 25,
                                  ),
                                  isThreeLine: true,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          'Check In Time',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          hotel.checkIn,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        leading: Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          'Check Out Time',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        subtitle: Text(
                                          hotel.checkOut,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        leading: Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                ListTile(
                                  title: Text(
                                    'Price',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: hotel.price.discounted
                                      ? Row(
                                          children: [
                                            Text(
                                              '${hotel.price.currency} ${hotel.price.beforePrice}',
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              '${hotel.price.currency} ${hotel.price.currentPrice}',
                                            ),
                                          ],
                                        )
                                      : Text(
                                          '${hotel.price.currency} ${hotel.price.currentPrice}',
                                        ),
                                  leading: Icon(
                                    Icons.money,
                                    color: Colors.green,
                                    size: 25,
                                  ),
                                ),
                                SizedBox(height: 15),
                                ListTile(
                                  title: Text(
                                    'Rating : ${hotel.rating}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  leading: Icon(
                                    Icons.star,
                                    color: Theme.of(context).accentColor,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        'Rooms',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Wrap(
                        children: hotel.rooms
                            .map((e) => Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
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
                                  height: 150,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                          'Price : ${hotel.price.currency} ${e.price}'),
                                      Text('Max Occupants : ${e.maxOccupants}'),
                                      Text(
                                          'Rooms Available : ${e.roomsAvailable}'),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Main Amenities',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: hotel.featureBullets.mainAmenities
                            .map(
                              (e) => Chip(
                                label: Text(
                                  e,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'What is around',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: hotel.featureBullets.whatIsAround
                            .map(
                              (e) => Chip(
                                label: Text(
                                  e,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 15),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            _recommendedHotels(),
          ],
        ),
      ),
    );
  }

  Widget _recommendedHotels() {
    return FutureBuilder<List<Hotel>>(
      future: NavigationController.getHotelRecommendationByIdController(
        hotelId: hotelId.toString(),
      ),
      builder: (context, snapshot) {
        final hotels = snapshot.data;
        if (snapshot.hasData) {
          return SizedBox(
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommended',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return RecommendHotelCard(hotels[index]);
                    },
                    itemCount: hotels.length,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
