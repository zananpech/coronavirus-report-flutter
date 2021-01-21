import 'package:coronavirus/home.dart';
import 'package:coronavirus/intro_screens.dart';
import 'package:coronavirus/loading.dart';
import 'package:coronavirus/speechtotext.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt('initScreen');
  print(initScreen);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initScreen == 1 ? 'loading' : 'boarding',
        routes: {
          'boarding': (context) => IntrodScreen(),
          'loading': (context) => Loading(),
          'home': (context) => Home(),
        });
  }
}
