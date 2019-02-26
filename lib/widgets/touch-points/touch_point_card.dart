import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../models/touch_point.dart';
import '../../scoped-models/main.dart';

class TouchPointCard extends StatelessWidget {
  final TouchPoint touchPoint;
  final int touchPointIndex;

  TouchPointCard(BuildContext context, this.touchPoint, this.touchPointIndex);

  Widget _buildTitle(BuildContext context) {
    TextTheme textTheme = Theme
      .of(context)
      .textTheme;
    return Container(
      padding: EdgeInsets.only(top: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(touchPoint.id, style: textTheme.subhead),
              Text(touchPoint.state, style: textTheme.caption),
            ],
          ),
          SizedBox(
            width: 8.0,
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator
                  .pushNamed<bool>(context,
                      '/product/' + model.allTouchPoints[touchPointIndex].id),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
      decoration: new BoxDecoration(
        color: Colors.grey.shade200.withOpacity(touchPoint.state == 'online' ? 0.4 : 0.2),
        borderRadius: new BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          _buildTitle(context),
          _buildIcon(context),
          Text(touchPoint.cashier ?? ''),
        ],
      ),
    );
  }
}
