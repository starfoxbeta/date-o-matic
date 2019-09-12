import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_tools.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class QuizProvider {
  Map<String, dynamic> _q1;
  Map<String, dynamic> get q1 => _q1;
  set setQuiz1(Map value) {
    _q1 = value;
  }

  Map<String, dynamic> _q2;
  Map<String, dynamic> get q2 => _q2;
  set setQuiz2(Map value) {
    _q2 = value;
  }

  Map<String, dynamic> _q3;
  Map<String, dynamic> get q3 => _q3;
  set setQuiz3(Map value) {
    _q3 = value;
  }

  Map<String, dynamic> _q4;
  Map<String, dynamic> get q4 => _q4;
  set setQuiz4(Map value) {
    _q4 = value;
  }

  Map<String, dynamic> _q5;
  Map<String, dynamic> get q5 => _q5;
  set setQuiz5(Map value) {
    _q5 = value;
  }

  Map<String, dynamic> _q6;
  Map<String, dynamic> get q6 => _q6;
  set setQuiz6(Map value) {
    _q6 = value;
  }
}

//--------------------------------------------------
class AppProvider with ChangeNotifier {
  RemoteConfig _value;
  RemoteConfig get value => _value;
  set setRemote(RemoteConfig config) {
    _value = config;
  }
}

class LoadProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setLoadingStatus(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

class MenuProvider with ChangeNotifier {
  int _selectedIndex = 0; //This is to know the selected item in the drawer
  int get selectedItem =>
      _selectedIndex; //This gets the selected index in the drawer
  set setIndex(int index) {
    _selectedIndex = index;
  }
}

class StylesSelectionProvider with ChangeNotifier {
  List<String> _list = [];
  List<String> get getList => _list;
  set addList(String name) {
    if (_list.contains(name)) {
      _list.remove(name);
    } else {
      _list.add(name);
    }
    notifyListeners();
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
