import 'package:flutter/material.dart';

void main() { 
  runApp(MyApp()); 
} 
 
class MyApp extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      title: 'App Authentification', 
      theme: ThemeData( 
        primarySwatch: Colors.blue, 
      ), 
      home: LoginPage(), 
    ); 
  }
}
class LoginPage extends StatefulWidget { 
  @override 
  _LoginPageState createState() => _LoginPageState(); 
} 
 
class _LoginPageState extends State<LoginPage> { 
  final _formKey = GlobalKey<FormState>(); 
  String email = ''; 
  String password = ''; 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Connexion'), 
      ), 
      body: Padding( 
        padding: const EdgeInsets.all(16.0), 
        child: Form( 
          key: _formKey, 
          child: Column( 
            children: [ 
              TextFormField( 
                decoration: InputDecoration(labelText: 'Email'), 
                validator: (value) { 
                  if (value == null || value.isEmpty) { 
                    return 'Veuillez entrer votre email'; 
                  } 
                  return null; 
   }, 
                onSaved: (value) { 
                  email = value!; 
                }, 
              ), 
              TextFormField( 
                decoration: InputDecoration(labelText: 'Mot de passe'), 
                obscureText: true, 
                validator: (value) { 
                  if (value == null || value.isEmpty) { 
                    return 'Veuillez entrer votre mot de passe'; 
                  } 
                  return null; 
                }, 
                onSaved: (value) { 
                  password = value!; 
                }, 
              ), 
              SizedBox(height: 20), 
              ElevatedButton( 
                onPressed: () { 
                  if (_formKey.currentState!.validate()) { 
                    _formKey.currentState!.save(); 
                    if (email == 'cad@mail.com' && password == '2024') { 
                      Navigator.push( 
                        context, 
                        MaterialPageRoute(builder: (context) => HomePage()), 
                      ); 
                    } else { 
                      ScaffoldMessenger.of(context).showSnackBar( 
                        SnackBar(content: Text('Identifiants incorrects')), 
 ); 
                    } 
                  } 
                }, 
                child: Text('Connexion'), 
              ), 
            ], 
          ), 
        ), 
      ), 
    ); 
  } 
} 
 
class HomePage extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: Text('Page d\'accueil'), 
      ), 
      body: Center( 
        child: Text('Bienvenue dans l’espace de cours à distance!'), 
      ), 
    ); 
  } 
} 