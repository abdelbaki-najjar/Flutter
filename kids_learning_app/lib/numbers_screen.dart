import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NumbersScreen extends StatelessWidget {
  final FlutterTts _flutterTts = FlutterTts(); // إنشاء كائن لتوليد الصوت

  final List<Map<String, String>> numbers = [
    {'number': '1', 'text': 'One'},
    {'number': '2', 'text': 'Two'},
    {'number': '3', 'text': 'Three'},
  ];

  void speakText(String text) async {
    await _flutterTts.speak(text); // توليد الصوت للنص المدخل
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            speakText(numbers[index]['text']!); // تشغيل الصوت عند النقر
          },
          child: Card(
            color: Colors.blue.shade100,
            child: Center(
              child: Text(
                numbers[index]['number']!,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
