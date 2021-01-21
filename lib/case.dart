import 'dart:convert';
import 'package:http/http.dart';

class Case {
  String country;
  // Case(String country) {
  //   this.country = country;
  // }
  var newRecover, remaining, newCase, newDeath;
  List data;

  Future<void> fetchdata() async {
    Response response = await get('https://covid-19.dataflowkit.com/v1');
    data = jsonDecode(response.body);
  }
}
