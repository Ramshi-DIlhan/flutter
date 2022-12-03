import 'package:cloud_firestore/cloud_firestore.dart';

final verified_hashes = ['a','b','c'];

class DatabaseService{
  String uid;
  DatabaseService({required this.uid});
  var collected_hashes = [];


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

  void playerJob(hash)async{
    await _db.collection('Players').doc(uid).get().then((value)async{
      collected_hashes = value.data()!['clues'];
      if(verified_hashes.contains(hash)){
        if(collected_hashes.contains(hash)){print('Hash already exists');}
        else{
          collected_hashes.add(hash);
          await _db.collection('Players').doc(uid).update({
            'clues':collected_hashes,
          });
        }
      }
      else{print('Invalid Hash code');}
    });
  }
}