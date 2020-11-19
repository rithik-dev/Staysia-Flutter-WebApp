import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staysia_web/models/user.dart';
import 'package:staysia_web/utils/DeviceDimension.dart';
import 'package:staysia_web/utils/constants.dart';
import 'package:staysia_web/views/login_page.dart';

import '../main.dart';

class SplashPage extends StatefulWidget {
  static const String id = '/splashScreen';

  @override
  _SplashPage createState() => _SplashPage();
}

// on-startup
// app loads--> splash screen--> handleJwt
// If jwt
//show him profile button and store jwt in provider
// else
// make jwt provider null and show him login button
// during use
// jwt expires --> push to login screen and remove key from shared_pref

class _SplashPage extends State<SplashPage> {
  Future checkFirstSeen() async {
    // ignore: omit_local_variable_types
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: omit_local_variable_types
    String jwt = prefs.getString('jwt');
    jwt = await _handleJwt(jwt);
    await getState(jwt);
    ACCESS_TOKEN = jwt;
    await Navigator.pushNamed(context, LoginPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: SpinKitCubeGrid(
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  Future getState(String jwt) async {
    setState(() {
      device = DeviceDimension(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width);
    });
    Provider.of<DeviceDimension>(context, listen: false)
        .updateDeviceInProvider(device: device);
    Provider.of<User>(context, listen: false).updateUserInProvider(user);
    Provider.of<User>(context, listen: false)
        .setLoggedInStatus(jwt != null && jwt != '');
  }

  User user = User(
    phone_number: '',
    email: '',
    name: '',
  );
  DeviceDimension device = DeviceDimension(width: 0.0, height: 0.0);

  Future<String> _handleJwt(String jwt) async {
    if (jwt == null) {
      logger.w('jwt is null');
      jwt = '';
      return jwt;
    }
    List jwtList = jwt.split('.');
    if (jwtList.length != 3) {
      logger.w('jwt is invalid');
      return '';
    } else {
      var payload = json.decode(
        ascii.decode(
          base64.decode(
            base64.normalize(jwtList[1] as String),
          ),
        ),
      );
      if (DateTime.fromMillisecondsSinceEpoch((payload['exp'] as int) * 1000)
          .isAfter(DateTime.now())) {
        return jwt;
      } else {
        return '';
      }
    }
  }
}
