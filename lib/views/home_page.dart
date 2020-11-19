import 'package:flutter/material.dart';
import 'package:staysia_web/main.dart';
import 'package:staysia_web/utils/constants.dart';

class HomePage extends StatefulWidget {
  static const id = '/homePage';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text("hi"),
            FlatButton(
              onPressed: () {
                logger.d(ACCESS_TOKEN);
              },
              child: Text("print"),
            )
          ],
        ),
      ),
    );
  }
}
