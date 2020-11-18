import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => Counter()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }
// class Counter with ChangeNotifier {
//   int _count = 0;
//
//   int get count => _count;
//
//   void increment() {
//     _count++;
//     notifyListeners();
//   }
// }
import 'package:staysia_web/models/user.dart';
import 'package:staysia_web/utils/DeviceDimension.dart';
import 'package:staysia_web/utils/constants.dart';
import 'package:staysia_web/utils/route_generator.dart';
import 'package:staysia_web/views/splash_page.dart';

void main() {
  runApp(MyApp());
}

final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();
var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 0, colors: true, printEmojis: true, printTime: false),
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[800],
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DeviceDimension>(
            create: (_) => DeviceDimension(width: 0.0, height: 0.0)),
        ChangeNotifierProvider<User>(
            create: (_) => User(phone_number: '', email: '', name: '')),
      ],
      child: MaterialApp(
        navigatorKey: nav,
        theme: kDefaultTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: SplashPage.id,
      ),
    );
  }
}
