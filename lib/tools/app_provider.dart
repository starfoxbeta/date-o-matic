import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_tools.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AppProvider with ChangeNotifier {
  RemoteConfig _value;
  RemoteConfig get value => _value;
  set setRemote(RemoteConfig config) {
    _value = config;
  }


}

class MenuProvider with ChangeNotifier{
  int _selectedIndex = 0; //This is to know the selected item in the drawer
  int get selectedItem =>
      _selectedIndex; //This gets the selected index in the drawer
  set setIndex(int index) {
    _selectedIndex = index;
  }
}

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        writeBoolDataLocally(key: connection, value: true);
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        writeBoolDataLocally(key: connection, value: true);
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        writeBoolDataLocally(key: connection, value: false);
        return ConnectivityStatus.Offline;
      default:
        writeBoolDataLocally(key: connection, value: false);
        return ConnectivityStatus.Offline;
    }
  }
}

enum ConnectivityStatus { WiFi, Cellular, Offline }
