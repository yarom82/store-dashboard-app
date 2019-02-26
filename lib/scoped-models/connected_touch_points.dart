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
