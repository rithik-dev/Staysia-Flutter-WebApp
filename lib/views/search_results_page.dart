import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:staysia_web/components/NoData.dart';
import 'package:staysia_web/components/custom_error_widget.dart';
import 'package:staysia_web/components/explore_drawer.dart';

import 'package:staysia_web/components/TopBarContents.dart';
import 'package:staysia_web/components/hotel_card.dart';

import 'package:staysia_web/components/responsive_widget.dart';
import 'package:staysia_web/controller/navigation_controller.dart';
import 'package:staysia_web/models/hotel.dart';

import 'home_page.dart';

class SearchResultsPage extends StatefulWidget {
  static const id = '/searchResults';

  final Map<String, dynamic> queryParams;

  const SearchResultsPage({@required this.queryParams});

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  Future getResults;

  @override
  void initState() {
    getResults = NavigationController.searchHotelWithNameController(
      q: widget.queryParams['q'] as String,
      checkIn: widget.queryParams['checkIn'] as String,
      checkOut: widget.queryParams['checkOut'] as String,
    );
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\nShowing results for ${widget.queryParams['q'] as String}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    "${widget.queryParams['checkIn'] == null ? '' : 'Check-In date: ${widget.queryParams['checkIn'] as String}\n'}${widget.queryParams['checkOut'] == null ? '' : 'Check-Out date: ${widget.queryParams['checkOut'] as String}'}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: getResults,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    // ignore: omit_local_variable_types
                    List<Widget> result = [];
                    (snapshot.data as List).forEach((element) {
                      result.add(HotelCard(element as Hotel));
                    });
                    if (result.isEmpty) {
                      return NoData(message: 'No results found');
                    } else {
                      return Expanded(
                        child: SingleChildScrollView(
                          child: Wrap(
                            children: result,
                          ),
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return CustomErrorWidget(
                      message: 'Error in fetching search result....',
                    );
                  } else {
                    return Center(
                      child: SpinKitCircle(
                        color: Theme.of(context).accentColor,
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
