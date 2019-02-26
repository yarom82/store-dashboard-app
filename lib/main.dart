import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
// import 'package:flutter/rendering.dart';

import './pages/auth.dart';
import './pages/touch_points.dart';
import './scoped-models/main.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColorBrightness: Brightness.dark,
            primarySwatch: Colors.green,
            primaryColorDark: Colors.green,
            accentColor: Colors.green,
            buttonColor: Colors.green),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/touchpoints': (BuildContext context) => TouchPointsPage(model),
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => TouchPointsPage(model));
        },
      ),
    );
  }
}
