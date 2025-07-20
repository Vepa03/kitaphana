import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitaphana/pages/LoginPage.dart';
import 'package:kitaphana/pages/UserNamePage.dart';
import 'package:kitaphana/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
  
}

class _RegistrationPageState extends State<RegistrationPage> {

  TextEditingController MailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  String errorMessage = '';


  Future <void> saveEmail (String email) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved mail', email);
  }

  @override
  void dispose(){
    MailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  void register() async{
    try {
      await authService.value.createAccount(
      email: MailController.text, 
      password: PasswordController.text);
      await saveEmail(MailController.text);
      next();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "There is an error";
      });
    }
  }
  void next(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Usernamepage()));
  }
  void popPage(){
    Navigator.pop(context);
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
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
            Text(errorMessage, style: TextStyle(color: Colors.red),),
            SizedBox(height: 10.0,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Loginpage()));
              },
              child: Text('Login Page')),
            SizedBox(height: 10.0,),
            SizedBox(
              child: ElevatedButton(onPressed: (){
                register();
              }, 
              child: Text("Register"),),
              
            ),
          ],
        ),
      ),
    );
  }
}