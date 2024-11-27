import 'package:firebase/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyD1pUQjBf_ilbQqW6iaThyggyrFkuiXhEU",
      authDomain: "crud-2621c.firebaseapp.com",
      projectId: "crud-2621c",
      storageBucket: "crud-2621c.firebasestorage.app",
      messagingSenderId: "1040500412304",
      appId: "1:1040500412304:web:7fce46cfdba0a8368aad15",
    ),);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
