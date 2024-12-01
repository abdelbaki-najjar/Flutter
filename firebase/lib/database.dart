import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethodes {
  // Add etudiant to Firestore
  Future<void> addEtudiantinfor(Map<String, dynamic> etudiantinfo, String id) async {
    return await FirebaseFirestore.instance
        .collection("Etudiants") 
        .doc(id) 
        .set(etudiantinfo); 
  }

  Future<Stream<QuerySnapshot>> getallstudents() async { 
    // Récupérer la collection "Etudiants" sous forme de Stream 
    return FirebaseFirestore.instance.collection("Etudiants").snapshots(); 
  }

  Future<void> updateEtudiantInfo(String id, Map<String, dynamic> newInfo) async {
    return await FirebaseFirestore.instance
        .collection("Etudiants")
        .doc(id)
        .update(newInfo);
  }

  Future<void> deleteEtudiant(String id) async {
    return await FirebaseFirestore.instance
        .collection("Etudiants")
        .doc(id)
        .delete();
  }
  
}
