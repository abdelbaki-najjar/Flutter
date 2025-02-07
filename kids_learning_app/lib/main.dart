import 'package:flutter/material.dart';
import 'package:kids_learning_app/auth_screen.dart';
import 'package:kids_learning_app/colors_screen.dart';
import 'package:kids_learning_app/firebase_options.dart';
import 'package:kids_learning_app/letters_screen.dart';
import 'package:kids_learning_app/numbers_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // استخدام خيارات التهيئة
  );
  runApp(KidsLearningApp());
}


class KidsLearningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kids Learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<Widget> _screens = [
    NumbersScreen(),
    LettersScreen(),
    ColorsScreen(),
  ];

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthScreen()), // العودة إلى شاشة تسجيل الدخول
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kids Learning App'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _signOut, // تسجيل الخروج
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.looks_one), label: 'Numbers'),
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Letters'),
          BottomNavigationBarItem(icon: Icon(Icons.color_lens), label: 'Colors'),
        ],
      ),
    );
  }
}

