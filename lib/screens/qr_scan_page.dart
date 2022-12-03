import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitpod_flutter_quickstart/service/auth.dart';
import 'package:gitpod_flutter_quickstart/service/database.dart';

class QrScanPage extends StatelessWidget {
  String uid;
  QrScanPage({Key? key,required this.uid}) : super(key: key);

  final _auth = AuthService();
  final text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _auth.listenAuth();
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {_auth.Logout();},
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.white
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              TextFormField(
                controller: text,
              ),
              ElevatedButton(
                onPressed: (){
                  DatabaseService(uid: uid).playerJob(text.text);
                },
                child: Text(
                  'press'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
