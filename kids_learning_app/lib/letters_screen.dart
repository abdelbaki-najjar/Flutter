import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class LettersScreen extends StatelessWidget {
  final FlutterTts _flutterTts = FlutterTts(); // إنشاء كائن لتوليد الصوت

  final List<String> letters = ['A', 'B', 'C', 'D', 'E'];

  void speakLetter(String letter) async {
    await _flutterTts.speak(letter); // نطق الحرف
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: letters.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(letters[index]),
            ),
            title: Text(
              'Letter ${letters[index]}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              speakLetter(letters[index]); // تشغيل الصوت عند النقر
            },
          ),
        );
      },
    );
  }
}
