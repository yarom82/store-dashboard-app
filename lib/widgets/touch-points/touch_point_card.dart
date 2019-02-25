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
          //TitleDefault(touchPoint.state),
          SizedBox(
            width: 8.0,
          ),
          // PriceTag(touchPoint.price.toString())
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        // return ButtonBar(
        //     alignment: MainAxisAlignment.center,
        //     children: <Widget>[
              return IconButton(
                icon: Icon(Icons.shopping_cart),
                //color: ,
                onPressed: () => Navigator
                        .pushNamed<bool>(context,
                            '/product/' + model.allTouchPoints[touchPointIndex].id),
              );
//              IconButton(
//                icon: Icon(model.allProducts[productIndex].isFavorite
//                    ? Icons.favorite
//                    : Icons.favorite_border),
//                color: Colors.red,
//                onPressed: () {
//                  model.selectProduct(model.allProducts[productIndex].id);
//                  model.toggleProductFavoriteStatus();
//                },
//              ),
            // ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
      .of(context)
      .textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
      decoration: new BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.3),
        borderRadius: new BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
//          FadeInImage(
//            image: NetworkImage(touchPoint.image),
//            height: 300.0,
//            fit: BoxFit.cover,
//            // placeholder: AssetImage('assets/images/food.jpg'),
//          ),
          _buildTitle(context),
          // AddressTag('Union Square, San Francisco'),
          _buildIcon(context),
          Text(touchPoint.cashier ?? ''),
        ],
      ),
    );
  }
}
