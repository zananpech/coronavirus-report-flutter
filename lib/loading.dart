import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:coronavirus/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'case.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String newCase;
  String newDeath;
  String activeCase;
  var result;
  List list = new List();
  void updateCase(List data, String dropdownValue) {
    for (int i = 0; i < data.length; i++) {
      if (data[i]['Country_text'] == dropdownValue) {
        newCase =
            data[i]['New Cases_text'] != '' ? data[i]['New Cases_text'] : '+0';
        newDeath = data[i]['New Deaths_text'] != ''
            ? data[i]['New Deaths_text']
            : '+0';
        activeCase = data[i]['Active Cases_text'];
        list.add(newCase);
        list.add(newDeath);
        list.add(activeCase);
      }
    }
  }

  void covidData() async {
    Case corona = new Case();
    await corona.fetchdata();
    result = await Connectivity().checkConnectivity();
    updateCase(corona.data, 'World');
    Navigator.pushReplacementNamed(context, 'home', arguments: {
      'data': corona.data,
      'world_data': list,
    });
  }

  @override
  void initState() {
    super.initState();
    covidData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        result == ConnectivityResult.none
            ? showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      content: Text('No Internet Connection'),
                    ))
            : Material(),
        Align(
            alignment: Alignment.center,
            child: Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_wv4mTG.json')),
      ],
    ));
  }
}
