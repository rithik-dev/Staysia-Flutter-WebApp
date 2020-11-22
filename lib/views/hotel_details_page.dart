import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:staysia_web/components/add_review.dart';
import 'package:staysia_web/components/custom_error_widget.dart';
import 'package:staysia_web/components/custom_text_form_field.dart';
import 'package:staysia_web/components/recommend_hotel_card.dart';
import 'package:staysia_web/controller/navigation_controller.dart';
import 'package:staysia_web/models/detailed_hotel.dart';
import 'package:staysia_web/models/hotel.dart';

import 'home_page.dart';

class HotelDetailsPage extends StatelessWidget {
  static const id = 'hotel_details_page';
  final int hotelId;

  const HotelDetailsPage({this.hotelId});

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
                          Container(
                            width: 400,
                            height: 350,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      hotel.mainImage,
                                    ))),
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
                                Wrap(
                                  children: [
                                    ListTile(
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
                                    SizedBox(
                                      width: 30,
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
                                        hotel.checkOut,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      leading: Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 25,
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
                                        'Price : ${hotel.price.currency} ${e.price}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'Max Occupants : ${e.maxOccupants}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'Rooms Available : ${e.roomsAvailable}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
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
                      Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ...hotel.review
                              .map(
                                (e) => Container(
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
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.name,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          e.title,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        subtitle: Text(
                                          '${e.review}',
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          'Rating : ${e.rating}',
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
                                ),
                              )
                              .toList(),
                          AddReview(hotelId: hotel.id)
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return CustomErrorWidget();
                } else {
                  return Center(
                      child: SpinKitCircle(
                    color: Theme.of(context).accentColor,
                  ));
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
        } else if (snapshot.hasError) {
          return CustomErrorWidget();
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
