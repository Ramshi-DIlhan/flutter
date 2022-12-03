import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gitpod_flutter_quickstart/screens/login_page.dart';
import 'package:gitpod_flutter_quickstart/screens/qr_scan_page.dart';
import 'package:gitpod_flutter_quickstart/service/database.dart';
import 'package:get/get.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  void SignUp(String name, String dept, String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      DatabaseService(uid: result.user!.uid).initPlayer(name, dept, email);
      Get.off(() => QrScanPage());
    } catch (e) {
      print(e);
    }
  }

  void SignIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.off(() => QrScanPage());
    } catch (e) {
      print(e);
    }
  }

  void Logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  void listenAuth()async{
    _auth.authStateChanges().listen((user) {
      if(user!=null){
        Get.off(()=>QrScanPage());
      }
      else{
        Get.off(()=>LoginPage());
      }
    });
  }
}
