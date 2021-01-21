import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TexttoSpeech extends StatelessWidget {
  final String text;
  TexttoSpeech(this.text);
  final FlutterTts tts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return null;
  }

  Future<void> speakOut(String newCase, String newDeath, String activeCase,
      String country) async {
    tts.speak(" confirmed case:" +
        newCase +
        "," +
        "Death case" +
        newDeath +
        "," +
        " Active case" +
        activeCase +
        "in" +
        country);
  }
}
