import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/touch_point.dart';
import '../models/user.dart';

class ConnectedTouchPointsModel extends Model {
  List<TouchPoint> _touchPoints = [];
  String _selTouchPointId;
  User _authenticatedUser;
  bool _isLoading = false;
}

mixin TouchPointsModel on ConnectedTouchPointsModel {
  bool _showOnlineTouchPoints = true;

  List<TouchPoint> get allTouchPoints {
    return List.from(_touchPoints);
  }

  List<TouchPoint> get displayedTouchPoints {
    if (_showOnlineTouchPoints) {
      return _touchPoints.where((TouchPoint touchPoint) => touchPoint.state == "online").toList();
    }
    return List.from(_touchPoints);
  }

  int get selectedTouchPointIndex {
    return _touchPoints.indexWhere((TouchPoint touchPoint) {
      return touchPoint.id == _selTouchPointId;
    });
  }

  String get selectedTouchPointId {
    return _selTouchPointId;
  }

  TouchPoint get selectedTouchPoint {
    if (selectedTouchPointId == null) {
      return null;
    }

    return _touchPoints.firstWhere((TouchPoint touchPoint) {
      return touchPoint.id == _selTouchPointId;
    });
  }

  bool get displayOnlyOnlineTouchPoints {
    return _showOnlineTouchPoints;
  }

  Future<Null> fetchTouchPoints() {
    _isLoading = true;
    notifyListeners();
    return http
    //.get('https://flutter-products.firebaseio.com/products.json')
        .get('https://poseventsapi.azurewebsites.net/status/4801')
        .then<Null>((http.Response response) {
      print('response: ' + response.body);
      final List<TouchPoint> fetchedTouchPointList = [];
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      List<dynamic> statuses = jsonResponse['posStatuses'];
      var posList = statuses.cast<Map<String, dynamic>>();

      posList.forEach((Map<String, dynamic> d) {
        final TouchPoint touchPoint = TouchPoint.fromJson(d);
        fetchedTouchPointList.add(touchPoint);
      });

      // final List<Map<String, dynamic>> touchPointListData = jsonResponse['data'];
      // touchPointListData.forEach((Map<String touchPointId, dynamic touchPointData> d) {
      //   print('touchPointData-first_name: ' + touchPointData['first_name']);
      //   print('touchPointId: ' + touchPointId);
      //   final TouchPoint touchPoint = TouchPoint(
      //       id: touchPointId,
      //       cashier: touchPointData['first_name'],
      //       state: 'state', // touchPointData['last_name'],
      //       type: touchPointData['last_name']);
      //   fetchedTouchPointList.add(touchPoint);
      // });
      final TouchPoint tp1 = new TouchPoint(id: '1', cashier: 'cashier 1', state: 'online', type: 'POS');
      final TouchPoint tp2 = new TouchPoint(id: '2', cashier: 'cashier 2', state: 'offline', type: 'POS');
      final TouchPoint tp3 = new TouchPoint(id: '3', cashier: 'cashier 3', state: 'online', type: 'SCO');
      final TouchPoint tp4 = new TouchPoint(id: '4', cashier: 'cashier 4', state: 'online', type: 'SCO');
      final TouchPoint tp5 = new TouchPoint(id: '5', cashier: 'cashier 5', state: 'online', type: 'SCO');
      final TouchPoint tp6 = new TouchPoint(id: '6', cashier: 'cashier 6', state: 'offline', type: 'SCO');
      final TouchPoint tp7 = new TouchPoint(id: '7', cashier: 'cashier 7', state: 'online', type: 'SCO');
      // fetchedTouchPointList.add(tp1);
      // fetchedTouchPointList.add(tp2);
      // fetchedTouchPointList.add(tp3);
      // fetchedTouchPointList.add(tp4);
      // fetchedTouchPointList.add(tp5);
      // fetchedTouchPointList.add(tp6);
      // fetchedTouchPointList.add(tp7);
      _touchPoints = fetchedTouchPointList;
      _isLoading = false;
      notifyListeners();
      _selTouchPointId = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  void selectTouchPoint(String touchPointId) {
    _selTouchPointId = touchPointId;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showOnlineTouchPoints = !_showOnlineTouchPoints;
    notifyListeners();
  }
}

mixin UserModel on ConnectedTouchPointsModel {
  void login(String email, String password) {
    _authenticatedUser =
        User(id: 'fdalsdfasf', email: email, password: password);
  }
}

mixin UtilityModel on ConnectedTouchPointsModel {
  bool get isLoading {
    return _isLoading;
  }
}
