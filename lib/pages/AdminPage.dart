import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitaphana/pages/RegistrationPage.dart';
import 'package:kitaphana/services/auth_service.dart';

class Adminpage extends StatefulWidget {
  const Adminpage({super.key});

  @override
  State<Adminpage> createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {

  String errorMessage = '';

  void logout() async{
    try {
      await  authService.value.signOut();
      next();
      
    } on FirebaseAuthException catch  (e) {
      errorMessage = e.message ?? "There is an error";
    }
    authService.value.signOut();
  }

  void next(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> RegistrationPage()), (Route<dynamic> route)=> false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            logout();
          }, child: Text("LogOut")),
          SizedBox(height: 30.0,),
          Text(errorMessage, style: TextStyle(color: Colors.red))
        ],
      ),
    );
  }
}