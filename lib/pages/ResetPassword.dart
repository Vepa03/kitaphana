import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitaphana/pages/AdminPage.dart';
import 'package:kitaphana/services/auth_service.dart';
import 'package:lottie/lottie.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final _keyForm = GlobalKey<FormState>();
  TextEditingController UsernameController = TextEditingController();
  String errorMessage = '';

  void reset() async{
    try {
      await authService.value.UpdateUsername(username: UsernameController.text);
      success();
      next();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "This is not working";
      });
    }
  }
  void next() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Adminpage()),
    );
  }

  void success() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        content: Text("Your Username is changed"),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _keyForm,
              child: Column(
                children: [
                  Text("Update Username", style: TextStyle(fontSize: width*0.07, color: Colors.black, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10.0,),
                  SizedBox(
                    width: width,
                    height: height*0.3,
                    child: Lottie.asset("lib/assets/lottie/updatepassword.json")),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text("Enter your New Username"),
                            prefix: Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Icon(Icons.person, color: Colors.black,),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: UsernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Username is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0,),
                        Text(errorMessage, style: TextStyle(color: Colors.green),),
                        SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.05,
                        child: ElevatedButton(onPressed: (){
                          if (_keyForm.currentState!.validate()) {
                            reset();
                          }
                        }, child: Text('Update', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),), 
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}