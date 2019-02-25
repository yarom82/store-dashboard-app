import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './touch_point_card.dart';
import '../../models/touch_point.dart';
import '../../scoped-models/main.dart';

class TouchPoints extends StatelessWidget {

  TouchPoints(BuildContext context);

  Widget _buildTouchPointList(BuildContext context, List<TouchPoint> touchPoints) {
    Widget touchPointCards;
    if (touchPoints.length > 0) {
      touchPointCards = GridView.count(
        crossAxisCount: 3,
        children: List.generate(touchPoints.length, (int index) {
          return TouchPointCard(context, touchPoints[index], index);
        })
      );
      // touchPointCards = ListView.builder(
      //   itemBuilder: (BuildContext context, int index) =>
      //       TouchPointCard(touchPoints[index], index),
      //   itemCount: touchPoints.length,
      // );
    } else {
      touchPointCards = Container();
    }
    return touchPointCards;
  }

  @override
  Widget build(BuildContext context) {
    
    print('[TouchPoints Widget] build()');
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        print('model.displayedTouchPoints: ' + model.displayedTouchPoints.length.toString());
        return  _buildTouchPointList(context, model.displayedTouchPoints);
    },);
  }
}
