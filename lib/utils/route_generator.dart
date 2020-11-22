import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:staysia_web/views/home_page.dart';
import 'package:staysia_web/views/hotel_details_page.dart';
import 'package:staysia_web/views/search_results_page.dart';
import 'package:staysia_web/views/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
// Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      // case ResourcesPage.id:
      //   return PageTransition(
      //     child: ResourcesPage(
      //       course: args,
      //     ),
      //     type: PageTransitionType.bottomToTop,
      //   );

      case HotelDetailsPage.id:
        return PageTransition(
            child: HotelDetailsPage(hotelId: args as int),
            type: PageTransitionType.leftToRightWithFade);
      case SearchResultsPage.id:
        return PageTransition(
            child: SearchResultsPage(queryParams: args as Map<String, dynamic>),
            type: PageTransitionType.leftToRightWithFade);
      case HomePage.id:
        return PageTransition(
            child: HomePage(), type: PageTransitionType.leftToRightWithFade);
      case SplashPage.id:
        return PageTransition(
            child: SplashPage(), type: PageTransitionType.leftToRightWithFade);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
