import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ColorsScreen extends StatelessWidget {
  final FlutterTts _flutterTts = FlutterTts(); // كائن Text-to-Speech

  final List<Map<String, dynamic>> colors = [
    {'color': Colors.red, 'name': 'Red'},
    {'color': Colors.green, 'name': 'Green'},
    {'color': Colors.blue, 'name': 'Blue'},
    {'color': Colors.yellow, 'name': 'Yellow'},
    {'color': Colors.purple, 'name': 'Purple'},
  ];

  void speakColorName(String colorName) async {
    await _flutterTts.setLanguage("en-US"); // تعيين اللغة الإنجليزية
    await _flutterTts.setPitch(1.0);        // تعيين نغمة الصوت
    await _flutterTts.setSpeechRate(0.5);  // تعيين سرعة النطق
    await _flutterTts.speak(colorName);    // نطق اسم اللون
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
      itemCount: colors.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            speakColorName(colors[index]['name']); // تشغيل الصوت عند النقر
          },
          child: Card(
            color: colors[index]['color'], // لون الخلفية
            child: Center(
              child: Text(
                colors[index]['name'], // اسم اللون
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
