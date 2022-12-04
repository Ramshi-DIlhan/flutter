import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gitpod_flutter_quickstart/service/auth.dart';

class SinglePlayerInfoPage extends StatelessWidget {
  var result;
  SinglePlayerInfoPage({super.key,required this.result});

  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('admin'),
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
          child: Column(
            children: [
              SizedBox(height: 50),
              Text('Name : ${result['name']}'),
              SizedBox(height: 20),
              Text('Department : ${result['dept']}'),
              SizedBox(height: 20),
              Text('Email : ${result['email']}'),
              SizedBox(height: 20),
              Text('Phone : ${result['phone']}'),
              SizedBox(height: 20),
              Text('Score : ${result['score']}'),
              SizedBox(height: 20),
              Text('# QR : ${(result['score']/100).toString().split('.')[0]}'),
            ],
          ),
        ),
    );
  }
}