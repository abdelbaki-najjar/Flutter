import 'package:firebase/etudiant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<QuerySnapshot>? etudiantsStream;

  getontheload() async {
    etudiantsStream = await DatabaseMethodes().getallstudents();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Widget allStudentsDetails() {
    return StreamBuilder<QuerySnapshot>(
      stream: etudiantsStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Aucun étudiant trouvé.'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];

            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nom : ${ds["Nom"]}", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    Text("Prénom : ${ds["Prenom"]}", style: TextStyle(fontSize: 18.0)),
                    Text("Âge : ${ds["Age"]}", style: TextStyle(fontSize: 18.0)),
                    Text("Poste : ${ds["Poste"]}", style: TextStyle(fontSize: 18.0)),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {

                            showEditDialog(ds.id, ds["Nom"], ds["Prenom"], ds["Age"], ds["Poste"]);
                          },
                        ),

                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {

                            DatabaseMethodes().deleteEtudiant(ds.id).then((_) {
                              Fluttertoast.showToast(
                                msg: "Étudiant supprimé avec succès",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              setState(() {

                                getontheload();
                              });
                            }).catchError((error) {
                              Fluttertoast.showToast(
                                msg: "Erreur de suppression : $error",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }


  void showEditDialog(String id, String nom, String prenom, String age, String poste) {
    TextEditingController nameController = TextEditingController(text: nom);
    TextEditingController surnameController = TextEditingController(text: prenom);
    TextEditingController ageController = TextEditingController(text: age);
    TextEditingController statutController = TextEditingController(text: poste);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modifier l\'étudiant'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(labelText: 'Prénom'),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Âge'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: statutController,
                decoration: InputDecoration(labelText: 'Poste'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {

                Map<String, dynamic> updatedInfo = {
                  "Nom": nameController.text,
                  "Prenom": surnameController.text,
                  "Age": ageController.text,
                  "Poste": statutController.text,
                };
                DatabaseMethodes().updateEtudiantInfo(id, updatedInfo).then((_) {
                  Fluttertoast.showToast(
                    msg: "Informations modifiées avec succès",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  setState(() {

                    getontheload();
                  });
                  Navigator.pop(context); 
                }).catchError((error) {
                  Fluttertoast.showToast(
                    msg: "Erreur de mise à jour : $error",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                });
              },
              child: Text('Modifier'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Étudiants Cours à Distance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              'Bienvenue sur la plateforme de cours à distance!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EtudiantPage()),
                );
              },
              child: Text('Plus'),
            ),
            SizedBox(height: 20),

            Expanded(child: allStudentsDetails()),
          ],
        ),
      ),
    );
  }
}
