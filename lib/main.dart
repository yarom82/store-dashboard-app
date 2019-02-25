import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
// import 'package:flutter/rendering.dart';

import './pages/auth.dart';
// import './pages/products_admin.dart';
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
        // home: AuthPage(),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/touchpoints': (BuildContext context) => TouchPointsPage(model),
          // '/admin': (BuildContext context) => ProductsAdminPage(model),
        },
        onGenerateRoute: (RouteSettings settings) {
          /*
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != ''git remote add origin /path/to/origin.git) {
            return null;
          }
          if (pathElements[1] == 'product') {
            final String productId = pathElements[2];
            final Product product = model.allProducts.firstWhere((Product product) {
              return product.id == productId;
            });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(product),
            );
          }
          return null;
          */
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => TouchPointsPage(model));
        },
      ),
    );
  }
}
