import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService{
  final _storage = FirebaseStorage.instance;

  Future<void> uploadFile( path, filename)async{
    final file = File(path);
    try{
      await _storage.ref(filename).putFile(file);
    }
    on FirebaseException catch(e){
      print(e.message);
    }
  }
}