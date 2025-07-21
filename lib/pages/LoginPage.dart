import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kitaphana/pages/MainPage.dart';
import 'package:kitaphana/pages/RegistrationPage.dart';
import 'package:kitaphana/services/auth_service.dart';
import 'package:lottie/lottie.dart';

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
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Mainpage()),
      (Route<dynamic> route) => false,
    );
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width,
                  height: height*0.3,
                  child: Lottie.asset('lib/assets/lottie/login.json')),
                SizedBox(height: 10.0,),
                TextFormField(
                    decoration: InputDecoration(
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Icon(Icons.person, color: Colors.black,),
                      ),
                      label: Text("Enter Your Mail", style: TextStyle(color: Colors.black),),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    controller: MailController,
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: InputDecoration(
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Icon(Icons.key, color: Colors.black,),
                      ),
                      label: Text("Enter Your Password", style: TextStyle(color: Colors.black)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    controller: PasswordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 10.0,),
                  Text(errorMessage, style: TextStyle(color: Colors.red),),
                  SizedBox(height: 10.0,),
                  SizedBox(
                        width: width,
                        height: height * 0.05,
                        child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: width * 0.06,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
            
                      Text.rich(
                        TextSpan(
                          text: "You don't have an account?  ",
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Click here',
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegistrationPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}