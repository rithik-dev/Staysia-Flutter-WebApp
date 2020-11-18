import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:staysia_web/views/login_page.dart';

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
      // case SearchPage.id:
      //   return PageTransition(
      //       child: SearchPage(), type: PageTransitionType.leftToRightWithFade);
      case LoginPage.id:
        return PageTransition(
            child: LoginPage(
              email: args != null ? (args as List)[0] as String : '',
              password: args != null ? (args as List)[1] as String : '',
            ),
            type: PageTransitionType.rightToLeftWithFade);
      default:
        return PageTransition(
            child: LoginPage(
              email: args != null ? (args as List)[0] as String : '',
              password: args != null ? (args as List)[1] as String : '',
            ),
            type: PageTransitionType.rightToLeftWithFade);
    }
  }
}
