import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/custom_tab_bar.dart';
import '../widgets/touch-points/touch_points.dart';
import '../scoped-models/main.dart';

class TouchPointsPage extends StatefulWidget {
  final MainModel model;

  TouchPointsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _TouchPointsPageState();
  }
}

class _TouchPointsPageState extends State<TouchPointsPage> {
  @override
  initState() {
    widget.model.fetchTouchPoints();
    super.initState();
  }

  PageController _pageController = new PageController(initialPage: 0);

  Widget _buildTouchPointsList(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(child: Text('No Touch Points Found!'));
        if (model.displayedTouchPoints.length > 0 && !model.isLoading) {
          content = Container(
            child: TouchPoints(context),
          );
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(onRefresh: model.fetchTouchPoints, child: content,) ;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget> pages = <String, Widget>{
      'All': _buildTouchPointsList(context),
      'Online': new Center(
        child: new Text('Only online POS'),
      ),
      'Approvals': new Center(
        child: new Text('Approvals required history'),
      ),
    };
    return Stack(
      children: [
        new Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                const Color.fromARGB(255, 38, 180, 20),
                const Color.fromARGB(255, 28, 60, 142),
              ],
              stops: [0.0, 1.0],
            )
          ),
        ),
        Scaffold(
          backgroundColor: const Color(0x00000000),
          appBar: AppBar(
            titleSpacing: 10.0,
            backgroundColor: const Color(0x00000000),
            elevation: 0.0,
            leading: Center(
              child: Image.asset(
                'assets/images/brand-logo.png',
                width: 40.0,
                height: 24.0,
                fit: BoxFit.fill,
              ),
            ),
            title: Center(
              child: Text('Store Dashboard')
            ),
            bottom: CustomTabBar(
              pageController: _pageController,
              pageNames: pages.keys.toList(),
            ),
            actions: <Widget>[
              ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child, MainModel model) {
                  return IconButton(
                    icon: Icon(model.displayOnlyOnlineTouchPoints
                        ? Icons.check_circle
                        : Icons.check_circle_outline),
                    onPressed: () {
                      model.toggleDisplayMode();
                    },
                  );
                },
              )
            ],
          ),
          body: PageView(
            controller: _pageController,
            children: pages.values.toList(),
          ),
        )
      ]
    );
  }
}
