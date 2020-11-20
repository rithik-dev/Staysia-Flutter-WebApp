import 'package:flutter/material.dart';
import 'package:staysia_web/components/TopBarContents.dart';
import 'package:staysia_web/components/bottom_bar.dart';
import 'package:staysia_web/components/city_card.dart';
import 'package:staysia_web/components/custom_error_widget.dart';
import 'package:staysia_web/components/explore_drawer.dart';
import 'package:staysia_web/components/responsive_widget.dart';
import 'package:staysia_web/components/web_scrollbar.dart';
import 'package:staysia_web/controller/navigation_controller.dart';
import 'package:staysia_web/models/get_citites.dart';

class HomePage extends StatefulWidget {
  static const id = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;
  Future<GetCities> getCities;

  void _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    getCities = NavigationController.getCitiesController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 0;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isLargeScreen(context) ||
              ResponsiveWidget.isMediumScreen(context)
          ? PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContents(_opacity),
            )
          : AppBar(
              backgroundColor:
                  Theme.of(context).primaryColor.withOpacity(_opacity),
              elevation: 0,
              title: Text(
                'EXPLORE',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
            ),
      drawer: ExploreDrawer(),
      body: WebScrollbar(
        color: Theme.of(context).accentColor,
        backgroundColor: Colors.blueGrey.withOpacity(0.3),
        width: 10,
        heightFraction: 0.3,
        controller: _scrollController,
        child: ListView(
          physics: ClampingScrollPhysics(),
          controller: _scrollController,
          children: [
            Stack(
              children: [
                Container(
                  child: SizedBox(
                    height: screenSize.height * 0.45,
                    width: screenSize.width,
                    child: Image.asset(
                      'images/cover.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    // FloatingQuickAccessBar(screenSize: screenSize),
                    Container(
                      child: Column(
                        children: const [
                          // Text('Lol')
                          // FeaturedHeading(
                          //   screenSize: screenSize,
                          // ),
                          // FeaturedTiles(screenSize: screenSize)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            FutureBuilder<GetCities>(
              future: getCities,
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
                  return Padding(
                      padding: EdgeInsets.all(30),
                      child: CircularProgressIndicator());
                }
              },
            ),
            BottomBar()
          ],
        ),
      ),
    );
  }
}
