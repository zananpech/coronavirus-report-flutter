import 'dart:async';
import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SpeechScreen(),
    );
  }
}

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  String outputText = 'Please say sth';
  final SpeechToText speech = SpeechToText();
  bool _isListening = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('hello'),
    );
    // return Scaffold(
    //   floatingActionButton: AvatarGlow(
    //     animate: _isListening,
    //     glowColor: Colors.red[200],
    //     endRadius: 80,
    //     duration: Duration(milliseconds: 2000),
    //     repeatPauseDuration: Duration(microseconds: 100),
    //     repeat: true,
    //     child: FloatingActionButton(
    //       onPressed: () async {
    //         startListening();
    //       },
    //       child: Icon(
    //         _isListening ? Icons.mic : Icons.mic_none,
    //       ),
    //     ),
    //   ),
    //   body: SingleChildScrollView(
    //     child: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text(
    //             outputText,
    //             style: TextStyle(
    //               fontSize: 12,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  void startListening() async {
    bool available = await speech.initialize();
    if (available) {
      setState(() {
        _isListening = true;
      });
      speech.listen(
        onResult: resultListener,
      );
    } else
      setState(() {
        _isListening = false;
        speech.stop();
      });
  }

  void resultListener(SpeechRecognitionResult result) {
    if (result.finalResult)
      setState(() {
        outputText = result.recognizedWords;
        _isListening = false;
        print(outputText);
      });
  }
}
