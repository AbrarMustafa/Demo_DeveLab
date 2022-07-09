import 'package:demo_develab/main.dart';
import 'package:demo_develab/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController textEditingController= TextEditingController();
  String DUMMYDATE="****_**-**";
  late String seldate;
  @override
  void initState() {
    super.initState();
    seldate=DUMMYDATE;
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 140),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 50,
                    ),
                    SizedBox(width: 20,),
                    Text(
                      "Deve Labs",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: "Header",

                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        labelText: 'Enter Name',
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      controller: textEditingController,
                      onChanged: (content) {
                        textEditingController..text = content..selection = TextSelection.collapsed(offset: 0);
                      },
                    ),
                  ),
                  SizedBox(height: 20.0,),
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
                            setState(() {});
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.grey.shade100,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      size: 18.0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      " $seldate",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                        alignment: Alignment.bottomRight,
                        height: 40,
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: ElevatedButton(
                          child: const Text('Login'),
                          onPressed: () {
                            if (textEditingController.text.toString().isEmpty)
                            {
                              showInSnackBar("Username Required");
                            }
                            else if(seldate==DUMMYDATE){
                              showInSnackBar("Select DOB");
                            }
                            else{
                              prefs!.setString(USERNAME,textEditingController.text.toString());
                              prefs!.setString(DOB,seldate);
                              Navigator.pushReplacementNamed(context, "/country", arguments: {'data': ""});
                            }
                          },
                        )

                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Fill details to get login, Login required for be part of app",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.0,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: "Header",

                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}