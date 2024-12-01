import 'package:firebase/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EtudiantPage extends StatefulWidget {
  @override
  _EtudiantPageState createState() => _EtudiantPageState();
}

class _EtudiantPageState extends State<EtudiantPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController statutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un Étudiant"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: surnameController,
              decoration: InputDecoration(labelText: "Prénom"),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: "Âge"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: statutController,
              decoration: InputDecoration(labelText: "Poste"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                String id = randomAlphaNumeric(10); 
                Map<String, dynamic> etudiantInfo = {
                  "Nom": nameController.text,
                  "Prenom": surnameController.text,
                  "id": id,
                  "Age": ageController.text,
                  "Poste": statutController.text,
                };

                await DatabaseMethodes().addEtudiantinfor(etudiantInfo, id);
                
                Fluttertoast.showToast(
                  msg: "Étudiant ajouté avec succès",
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                );

                nameController.clear();
                surnameController.clear();
                ageController.clear();
                statutController.clear();
              },
              child: Text("Ajouter Nouvel Étudiant"),
            ),
          ],
        ),
      ),
    );
  }
}
