import 'package:demo_develab/models/api/Country/getCountry.dart';
import 'package:demo_develab/models/api/blogPosts/getBlogPosts.dart';
import 'package:demo_develab/utils/consts.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomHttpRequest {

//----------------------------------- API-----------------------------------------------------//

  //HTTP : Covid Country
  Future<GetCountry?> getCountryResponce(double lat,double lon) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final response = await http.get(Uri.parse(COUNTRY_URL+"&lat=$lat&lon=$lon"),headers: headers);//filter[limit] =-1

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return GetCountry.fromJson(responseJson);
     } else {
      return null;
    }
  }
  //HTTP : Covid Responce
  Future<List<GetCovidItems>> getCovidResponce(String country, String from, String to) async {//2020-11-09
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    final response = await http.get(Uri.parse(COVID_URL+"${country}?from=$from&to=$to"),headers: headers);//filter[limit] =-1
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return List<GetCovidItems>.from(responseJson.map((data) => GetCovidItems.fromJson(data)));
    } else {
      return [];
    }
  }
}