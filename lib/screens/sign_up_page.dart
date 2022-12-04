import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitpod_flutter_quickstart/screens/login_page.dart';
import 'package:gitpod_flutter_quickstart/service/auth.dart';
import 'package:gitpod_flutter_quickstart/service/controller.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final name = TextEditingController();
  final dept = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final _fkey = GlobalKey<FormState>();
  final _auth = AuthService();
  final _cont = Controller();

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
                 SizedBox(height: 10),
                Obx(() {
                  return Text(
                    _cont.error.value,
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  );
                }),
                SizedBox(height: 10),
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
                  onTap: () async{
                    if (_fkey.currentState!.validate()) {
                      _cont.error.value = await _auth.SignUp(name.text, dept.text, email.text, password.text);
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
        return val!.isEmpty ? 'Please Enter Correct Details': (obscure==true && val.length <8 ? 'Password must contain atleast 8 charecters':null);
      },
    );
  }
}

// if(val!=null){
//   if(obs=true || val.leng<5){
//     return slfkd
//   }
//   else if()
//   else return null
// }
// else{return null}




// com.example.gitpod_flutter_quickstart