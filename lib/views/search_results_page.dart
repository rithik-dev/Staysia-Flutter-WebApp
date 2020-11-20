import 'package:flutter/material.dart';
import 'package:staysia_web/components/hotel_card.dart';
import 'package:staysia_web/models/hotel.dart';

class SearchResultsPage extends StatelessWidget {
  static const id = '/searchResults';

  final Map<String, dynamic> results;

  const SearchResultsPage({@required this.results});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemBuilder: (context, index) {
            return HotelCard(results['results'][index] as Hotel);
          },
          itemCount: (results['results'] as List).length,
        ),
      ),
    );
  }
}
