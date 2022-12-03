import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitpod_flutter_quickstart/screens/qr.dart';
import 'package:gitpod_flutter_quickstart/service/auth.dart';
import 'package:gitpod_flutter_quickstart/service/controller.dart';
import 'package:gitpod_flutter_quickstart/service/database.dart';

class QrScanPage extends StatefulWidget {
  String uid;
  QrScanPage({Key? key,required this.uid}) : super(key: key);

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  final _auth = AuthService();

  final text = TextEditingController();


  double i = 0;

  @override
  Widget build(BuildContext context) {
    DatabaseService(uid: widget.uid).updateScore(update);
    _auth.listenAuth();
    return Scaffold(
      appBar: AppBar(
        title: Text('score: ${i.toString().split('.')[0]}'),
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
              SizedBox(height: 100),
              SizedBox(
                height: 300,
                width: 300,
                child: QrCamera(uid: widget.uid,update: update),
              ),
              SizedBox(height: 50),
              Text('Scan QR codes in your campus')
            ],
          ),
        ),
      ),
    );
  }

  void update(double score)async{
    setState(() {
      i = score*100.toInt();
    });
  }
}
