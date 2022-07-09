import 'package:demo_develab/http/httprequest.dart';
import 'package:demo_develab/main.dart';
import 'package:demo_develab/models/api/Country/getCountry.dart';
import 'package:demo_develab/models/api/blogPosts/getBlogPosts.dart';
import 'package:demo_develab/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

List<GetCovidItems> covidResults=[];

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {

  Position? position;
  GetCountry? getCountry;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  LocationPermission? permission;

  _checkPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return;
    }
    position =
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print("");
  }

  _getCurrentLocation() async {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }
    position =
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print("");
  }

  // getLocation() async {
  //   // position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }
  _getCountry() async {
    await _getCurrentLocation();
    if (position != null)
      getCountry = (await CustomHttpRequest().getCountryResponce(
          position!.latitude, position!.longitude))!;
  }

  Future<List<GetCovidItems>> _getCovidData() async {
    await _getCountry();

    DateTime now = DateTime.now();
    DateTime pastWeek = now.subtract(const Duration(days: 7));
    if (getCountry != null) {
      isDataFetched = true;
      return await CustomHttpRequest().getCovidResponce(
          getCountry!.address.country_code, pastWeek.toString(),
          now.toString());
    }
    else {
      isDataFetched = true;
      return <GetCovidItems>[];
    }
  }

  bool isDataFetched = false;

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = new ScrollController();

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              child: FutureBuilder(
                  future: _getCovidData(),
                  initialData: <GetCovidItems>[],
                  builder: (BuildContext context, AsyncSnapshot<List<GetCovidItems>> data) {
                    if (data.data == null)
                      return permissionWidget();
                    if (data.data!.isEmpty) {
                      return (isDataFetched && permission != null &&
                          permission != LocationPermission.denied)
                          ? permissionWidget() : Center(
                        child: CircularProgressIndicator(),
                        heightFactor: 30,
                        widthFactor: 30,);
                    }
                    else {
                      covidResults=data.data!;
                      List finalList=covidResults.reversed.toList();
                      return Container(
                        child: ListView.builder(
                          itemCount: finalList.length,
                          controller: _scrollController,
                          itemBuilder: (context, int index) {
                            return cartItems(finalList[index], index);
                          },
                        ),
                      );
                    }
                  })
          )
      ),
    );
  }

  Widget permissionWidget() {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Permission Required: Go to permission and allow"),
      ],
    ));
  }






  double boxSize=70;
  Widget cartItems(GetCovidItems item,int index) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    // DateTime dateTime = dateFormat.parse(item.toString().split("T")[0]);
    return Container(
      height: 100,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.transparent,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Date: ${item.Date.split("T")[0].toString()}".toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16,
                            fontFamily: "Normal",
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ), Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recovered: ${item.Recovered}".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 13,
                                  fontFamily: "Normal",
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            Text(
                              "Deaths: ${item.Deaths}".toUpperCase(),
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: "Normal",
                                fontWeight: FontWeight.w700,

                              ),
                            ),
                          ],
                        ),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Active: ${item.Active}".toUpperCase(),
                              style: TextStyle(
                                  fontFamily: "Normal",
                                  color: Colors.blueAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}