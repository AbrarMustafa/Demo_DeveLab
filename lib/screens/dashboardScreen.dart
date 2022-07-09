import 'package:demo_develab/WidgetHelper/CustomIcons.dart';
import 'package:demo_develab/utils/appTheme.dart';
import 'package:demo_develab/widgets/account_widget.dart';
import 'package:demo_develab/widgets/dashboard_widget.dart';
import 'package:demo_develab/widgets/map_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo_develab/main.dart';
import 'package:demo_develab/utils/consts.dart';

class DashboardScreen extends StatefulWidget  {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DashboardScreen>   {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool enabled = false; // tracks if drawer should be opened or not
  @override
  void initState() {
    super.initState();

  }

  int TabBarCount=3;
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(  // Added
        length: TabBarCount,  // Added
        initialIndex: 0, //Added
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: BackgroundColor,
            bottomNavigationBar: navTabItem(context),
            body: SafeArea(
              child: body(),
            )
        )
    );
  }

  Widget body() {

    List<Widget> tabChilds=[
      DashboardWidget(),
      MapWidget(),
      AccountWidget(),
    ];

    return Container(
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 10,
            child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: tabChilds
            ),
          ),
        ],
      ),
    );
  }

}
