import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitaphana/pages/MainPage.dart';
import 'package:kitaphana/services/auth_service.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController MailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  String errorMessage = '';


  void login() async {
    try {
      await authService.value.signIn(
        email: MailController.text, 
        password: PasswordController.text);
        next();
    }on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "There is an error";
      });
    }
  }

  void next(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Mainpage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
              decoration: InputDecoration(
                prefix: Icon(Icons.person),
                label: Text("Write Your Mail"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              controller: MailController,
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              decoration: InputDecoration(
                prefix: Icon(Icons.person),
                label: Text("Write Your Password"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              controller: PasswordController,
              obscureText: true,
            ),
            SizedBox(height: 10.0,),
            Text(errorMessage, style: TextStyle(color: Colors.red),),
            SizedBox(
              child: ElevatedButton(onPressed: (){
                login();
              }, 
              child: Text("Login"),),
              
            ),
        ],
      ),
    );
  }
}