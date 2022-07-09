import 'package:demo_develab/utils/appTheme.dart';
import 'package:flutter/material.dart';

Widget navTabItem(BuildContext context) {
  double iconSize = 28;
  List<Widget> tabList = [
    Tab(
      icon: Icon(Icons.dashboard, color: Theme.of(context).primaryColor, size: 25,), //,color: NormalColor,
    ),
    Tab(
      icon: Icon(Icons.location_city_sharp, color: Theme.of(context).primaryColor, size: 25,), //,color: NormalColor,
    ),
    Tab(
      icon: Icon(Icons.account_circle_outlined, color: Theme.of(context).primaryColor, size: 25,), //,color: NormalColor,
    )
  ];

  return TabBar(
    labelColor: MainHighlighter,
    unselectedLabelColor: MainHighlighter,
    indicatorPadding: EdgeInsets.all(5.0),
    indicatorColor: SecondaryHighlighter,
    indicatorSize: TabBarIndicatorSize.label,
    tabs: tabList,
  );
}

