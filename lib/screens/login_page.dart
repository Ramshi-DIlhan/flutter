import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitpod_flutter_quickstart/screens/sign_up_page.dart';
import 'package:gitpod_flutter_quickstart/service/auth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final email = TextEditingController();
  final password = TextEditingController();

  final _fkey = GlobalKey<FormState>();
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        actions: [
          ElevatedButton(
            onPressed: () {Get.off(()=>SignUpPage());},
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: SingleChildScrollView(
          child: Form(
            key: _fkey,
            child: Column(
              children: [
                SizedBox(height: 100),
                textfield('Email', email, false),
                SizedBox(height: 20),
                textfield('Password', password, true),
                SizedBox(height: 20),
                GestureDetector(
                  child: Container(
                    height: 50,
                    width: 500,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (_fkey.currentState!.validate()) {
                      _auth.SignIn(email.text, password.text);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textfield(String name, TextEditingController cont, bool obscure) {
    return TextFormField(
      controller: cont,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: name,
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
      ),
      validator: (val) {
        return val!.isEmpty ? 'Please Enter Correct Details..!' : null;
      },
    );
  }
}
