import 'package:coronavirus/home.dart';
import 'package:coronavirus/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<PageViewModel> getPages() {
  return [
    PageViewModel(
      decoration: PageDecoration(
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      image: Image.asset(
        'images/location.jpg',
      ),
      title: 'Select a country',
      body: 'you wish to gain the information of covid19 from the sidebar',
    ),
    PageViewModel(
      image: Image.asset('images/voice_assistant.jpg'),
      title: 'Voice assistant',
      body: 'Tell me the name of the country you desire, for example, Cambodia',
    ),
  ];
}

class IntrodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroductionScreen(
        dotsDecorator:
            DotsDecorator(color: Colors.grey, activeColor: Colors.blueAccent),
        next: Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
        pages: getPages(),
        showSkipButton: true,
        skip: Text(
          'Skip',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onSkip: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt('initScreen', 1);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Loading()));
        },
        onDone: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt('initScreen', 1);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Loading()));
        },
        done: Text(
          'Done',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        globalBackgroundColor: Colors.white,
      ),
    );
  }
}
