import 'package:flutter/cupertino.dart';

class DeviceDimension extends ChangeNotifier {
  double height;
  double width;

  DeviceDimension({this.height, this.width});

  void updateDeviceInProvider({DeviceDimension device}) {
    // ignore: unnecessary_this
    this.width = device.width;
    // ignore: unnecessary_this
    this.height = device.height;
    notifyListeners();
  }
}
