import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  String uid;
  DatabaseService({required this.uid});


  final _db = FirebaseFirestore.instance;

  void initPlayer(String name, String dept,String email)async{
    await _db.collection('Players').doc(uid).set({
      'name':name,
      'dept':dept,
      'email':email,
      'uid':uid,
      'clues':[],
    });
  }
}