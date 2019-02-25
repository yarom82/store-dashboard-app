import 'package:flutter/material.dart';

class CustomTabBar extends AnimatedWidget implements PreferredSizeWidget {
  CustomTabBar({ this.pageController, this.pageNames })
    : super(listenable: pageController);

  final PageController pageController;
  final List<String> pageNames;

  @override
  final Size preferredSize = new Size(0.0, 40.0);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
      .of(context)
      .textTheme;
    return new Container(
      height: 40.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: new BoxDecoration(
        color: Colors.grey.shade800.withOpacity(0.3),
        borderRadius: new BorderRadius.circular(20.0),
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: new List.generate(pageNames.length, (int index) {
          return new InkWell(
            child: new Text(
              pageNames[index],
              style: textTheme.subhead.copyWith(
                color: Colors.white.withOpacity(
                  index == pageController.page ? 1.0 : 0.2,
                ),
              )
            ),
            onTap: () {
              pageController.animateToPage(
                index,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );
            }
          );
        })
          .toList(),
      ),
    );
  }
}
