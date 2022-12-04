import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitpod_flutter_quickstart/screens/qr.dart';
import 'package:gitpod_flutter_quickstart/service/auth.dart';
import 'package:gitpod_flutter_quickstart/service/controller.dart';
import 'package:gitpod_flutter_quickstart/service/database.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanPage extends StatefulWidget {
  String uid;
  QrScanPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  final _auth = AuthService();

  final text = TextEditingController();
  final cameraController = MobileScannerController();

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
            onPressed: () {
              _auth.Logout();
            },
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white),
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
                child: QrCamera(
                  uid: widget.uid,
                  update: update,
                  ctx: context,
                  cont: cameraController,
                ),
              ),
              SizedBox(height: 50),
              Text('Scan QR codes in your campus'),
              SizedBox(height: 30),
              IconButton(
                color: Colors.white,
                icon: ValueListenableBuilder(
                  valueListenable: cameraController.torchState,
                  builder: (context, state, child) {
                    switch (state as TorchState) {
                      case TorchState.off:
                        return const Icon(Icons.flash_off, color: Colors.grey);
                      case TorchState.on:
                        return const Icon(Icons.flash_on, color: Colors.blue);
                    }
                  },
                ),
                iconSize: 32.0,
                onPressed: () => cameraController.toggleTorch(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void update(double score) async {
    setState(() {
      i = score * 100.toInt();
    });
  }
}
