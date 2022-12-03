import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitpod_flutter_quickstart/screens/login_page.dart';
import 'package:gitpod_flutter_quickstart/service/auth.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final name = TextEditingController();
  final dept = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final _fkey = GlobalKey<FormState>();
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        actions: [
          ElevatedButton(
            onPressed: () {Get.off(()=>LoginPage());},
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  'Login',
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
                textfield('Name', name, false),
                SizedBox(height: 20),
                textfield('Department', dept, false),
                SizedBox(height: 20),
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
                        'Register',
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
                      _auth.SignUp(name.text, dept.text, email.text, password.text);
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
