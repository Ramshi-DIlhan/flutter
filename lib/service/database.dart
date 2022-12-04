import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gitpod_flutter_quickstart/service/controller.dart';

final verified_hashes = ['yt78tXhOJ5ppc3oX35G3','d8O1AsrEcozf0f0aJA6P','QPbRhH9KEd5OQcCTK0Sp','zRTNdAYHMipiajZ94bBc','093t5p9msaIVStERUaey','4DaeFx00tZWBtU6z7yAU','TLIh20xFstjk0Iv8m8Qv'];

class DatabaseService{
  String uid;
  DatabaseService({required this.uid});
  var collected_hashes = [];


  final _db = FirebaseFirestore.instance;

  void initPlayer(String name, String dept,String email,String phone)async{
    await _db.collection('Players').doc(uid).set({
      'name':name,
      'dept':dept,
      'email':email,
      'phone':phone,
      'uid':uid,
      'score':0,
      'clues':[],
    });
  }

  void playerJob(hash,Function update,BuildContext context)async{
    await _db.collection('Players').doc(uid).get().then((value)async{
      collected_hashes = value.data()!['clues'];
      if(verified_hashes.contains(hash)){
        if(collected_hashes.contains(hash)){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('This QR Code is already Scanned'),backgroundColor: Colors.red));}
        else{
          collected_hashes.add(hash);
          await _db.collection('Players').doc(uid).update({
            'clues':collected_hashes,
            'score':collected_hashes.length*100,
          }).then((val){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Woo..hoo..You Found a QR Code'),backgroundColor: Colors.green));});
          update(collected_hashes.length);
        }
      }
      else{ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid QR code'),backgroundColor: Colors.red));}
    });
  }

  List<QueryDocumentSnapshot> allPlayers = [];

  Future<List> AdminFetch()async{
    await _db.collection('Players').orderBy('score',descending: true).get().then((value) {
      value.docs.forEach((element) {
        allPlayers.add(element);
      });
    });
    return allPlayers;
  }

  Future<Map<String, dynamic>?> PlayerFetch(String id)async{
    var s;
    await _db.collection('Players').doc(id).get().then((value) {
      s= value.data();
    });
    return s;
  }

 void updateScore(Function update)async{
 await _db.collection('Players').doc(uid).get().then((value)async{
  update(value.data()!['score']/100);
 }); 
 }
}