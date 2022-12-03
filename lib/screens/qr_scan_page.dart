import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitpod_flutter_quickstart/service/auth.dart';

class QrScanPage extends StatelessWidget {
  QrScanPage({Key? key}) : super(key: key);

  final _auth = AuthService();

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
    );
  }
}
