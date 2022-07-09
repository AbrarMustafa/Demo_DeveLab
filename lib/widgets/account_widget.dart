import 'package:demo_develab/main.dart';
import 'package:demo_develab/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AccountWidget extends StatefulWidget {
  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {

  @override
  void initState() {
    super.initState();
  }

  late String seldate ;
  @override
  Widget build(BuildContext context) {
    seldate= prefs!.getString(DOB)??"****:**:**";

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      size: 50.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 5,),
                  Column(
                    children: [
                      Text(
                        "${prefs!.getString(USERNAME)} ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 15.0),
                      ),
                      Text(
                        "Update your profile details, Click on Date",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12.0),
                      ),
                    ],
                  )
                  ],
                ),
              ),
          InkWell(
                onTap: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                        seldate = '${date.year} : ${date.month} : ${date.day}';
                        prefs!.setString(DOB,seldate);
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Column(
                  children: [
                    Card(
                      color: Colors.blueAccent,
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.date_range,
                                    size: 18.0,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    " $seldate",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Card(
                      color: Colors.red,
                      child: InkWell(
                        onTap: (){
                          prefs!.remove(USERNAME);
                          prefs!.remove(DOB);
                          Navigator.pushReplacementNamed(context, "/login");
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.cleaning_services_outlined,
                                      size: 18.0,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      "Remove Account",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}