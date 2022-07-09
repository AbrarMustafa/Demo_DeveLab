import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:demo_develab/main.dart';
import 'package:demo_develab/utils/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String currencyCode="";

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  startTime() async {
    var _duration = new Duration(milliseconds: 3500);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if(prefs!=null) {
      if (prefs!.containsKey(USERNAME) )
        Navigator.pushReplacementNamed(context, "/country");
      else
        Navigator.pushReplacementNamed(context, "/login");
    }else
      Navigator.pushReplacementNamed(context, "/login");

  }

  Future getPrefences() async{
    prefs = await SharedPreferences.getInstance();
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

     if(prefs==null) {
       getPrefences().then((value) {
         setState(() {});
       });
       return Scaffold(
           backgroundColor: Colors.white,
           body: Container()
       );
     }
     else {
       startTime();

       return Scaffold(
           body: Container(
             child: Center(
               child: Flex(
                 direction: Axis.vertical,
                 children: <Widget>[
                   Expanded(
                       flex: 1,
                       child: Container()
                   ),
                   Expanded(
                     flex: 1,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Image.asset(
                           'assets/logo.png',
                           width: 80,
                         ),
                         Text(
                           "CovidRxEi _ DeveLabs Demo Project",
                           style: TextStyle(
                             color: Colors.black87,
                             fontSize: 18.0,
                             overflow: TextOverflow.ellipsis,
                             fontFamily: "Header",

                           ),
                         ),
                       ],
                     ),
                   ),
                   Expanded(
                     flex: 2,
                     child: Container()
                   ),

                   Expanded(
                       flex: 1,
                       child: Column(
                         children: [
                           Center(
                             child: TypewriterAnimatedTextKit(
                                 isRepeatingAnimation: false,
                                 onTap: () {
                                   print("Tap Event");
                                 },
                                 text: [
                                   ". . . . . . . . . . . . ",
                                   ". . . . . . . . . . . . ",
                                 ],
                                 textStyle: TextStyle(
                                     color: Colors.black87,
                                     fontSize: 28.0,
                                     fontFamily: "Normal")
                             ),
                           ),
                           Text(
                             "©2022-2023 DeveLab All Rights Reserved",
                             style: TextStyle(
                               color: Colors.black87,
                               fontSize: 14.0,
                               overflow: TextOverflow.ellipsis,
                               fontFamily: "Header",

                             ),
                           ),
                         ],
                       )
                   ),

                 ],
               ),
             )
           )
       );
     }
  }


}