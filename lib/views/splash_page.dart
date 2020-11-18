import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staysia_web/models/user.dart';
import 'package:staysia_web/utils/DeviceDimension.dart';
import 'package:staysia_web/views/home_page.dart';
import 'package:staysia_web/views/login_page.dart';

import '../main.dart';

class SplashPage extends StatefulWidget {
  static const String id = '/splashScreen';

  @override
  _SplashPage createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  Future checkFirstSeen() async {
    // ignore: omit_local_variable_types
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: omit_local_variable_types
    String jwt = prefs.getString('jwt');
    await _handleJwt(jwt);
    await getState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitCubeGrid(
        color: Theme.of(context).accentColor,
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  Future getState() async {
    setState(() {
      device = DeviceDimension(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width);
      // user = User.fromDocumentSnapshot(userSnapshot);
    });
    Provider.of<DeviceDimension>(context, listen: false)
        .updateDeviceInProvider(device: device);
    Provider.of<User>(context, listen: false).updateUserInProvider(user);
  }

  User user = User(
    phone_number: '',
    email: '',
    name: '',
  );
  DeviceDimension device = DeviceDimension(width: 0.0, height: 0.0);

  Future<void> _handleJwt(String jwt) async {
    if (jwt == null) {
      logger.w('jwt is null');
      jwt = '';
    }
    if (jwt != '') {
      List jwtList = jwt.split('.');
      if (jwtList.length != 3) {
        logger.w('jwt is invalid');
        await Navigator.popAndPushNamed(context, LoginPage.id);
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
          await Navigator.popAndPushNamed(context, HomePage.id);
        } else {
          await Navigator.popAndPushNamed(context, LoginPage.id);
        }
      }
    } else {
      await Navigator.popAndPushNamed(context, LoginPage.id);
    }
  }
}
