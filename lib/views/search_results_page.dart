import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:staysia_web/components/hotel_card.dart';
import 'package:staysia_web/controller/navigation_controller.dart';
import 'package:staysia_web/models/hotel.dart';

class SearchResultsPage extends StatelessWidget {
  static const id = '/searchResults';

  final Map<String, dynamic> queryParams;

  const SearchResultsPage({@required this.queryParams});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
            future: NavigationController.searchHotelWithNameController(
              q: queryParams['q'] as String,
              checkIn: queryParams['checkIn'] as String,
              checkOut: queryParams['checkOut'] as String,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return HotelCard(snapshot.data[index] as Hotel);
                  },
                  itemCount: (snapshot.data as List).length,
                );
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
