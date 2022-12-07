import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gitpod_flutter_quickstart/screens/admin_page.dart';
import 'package:gitpod_flutter_quickstart/screens/login_page.dart';
import 'package:gitpod_flutter_quickstart/screens/qr_scan_page.dart';
import 'package:gitpod_flutter_quickstart/service/database.dart';
import 'package:get/get.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<String> SignUp(String name, String dept, String email, String password,String phone) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      DatabaseService(uid: result.user!.uid).initPlayer(name, dept, email.trim(),phone);
      Get.off(() => QrScanPage(uid: result.user!.uid,));
      return '';
    }on FirebaseAuthException catch (e) {
      // print(e.code);
      if(e.code == 'wrong-password')return 'Incorrect Password';
      else if(e.code=='user-not-found')return 'Incorrect Username';
      else if(e.code=='invalid-email')return 'Email Format is not correct (eg:example@gmail.com)';
      else if(e.code=='email-already-in-use')return 'Email is already registered';
      else return e.message.toString();
    }
  }

  Future<String> SignIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      Get.off(() => QrScanPage(uid: result.user!.uid,));
      return '';
    }on FirebaseAuthException catch (e) {
      // print(e.code);
      if(e.code == 'wrong-password')return 'Incorrect Password';
      else if(e.code=='user-not-found')return 'Incorrect Username';
      else if(e.code=='invalid-email')return 'Email Format is not correct (eg:example@gmail.com)';
      else if(e.code=='email-already-in-use')return 'Email is already registered';
      else return e.message.toString();
    }
  }

  void Logout() async {
    try {
      await _auth.signOut();
      Get.off(()=>LoginPage());
    } catch (e) {
      print(e);
    }
  }

  void listenAuth()async{
    _auth.authStateChanges().listen((user) {
      if(user!.uid=='e8LRMEBAeZeDVYxFTkj7zX0HiST2'){
        Get.off(()=>AdminPage());
      }
      else if(user!=null){
        Get.off(()=>QrScanPage(uid: user.uid,));
      }
      else{
        Get.off(()=>LoginPage());
      }
    });
  }


}
