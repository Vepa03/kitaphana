import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kitaphana/pages/LoginPage.dart';
import 'package:kitaphana/pages/UserNamePage.dart';
import 'package:kitaphana/services/auth_service.dart';
import 'package:lottie/lottie.dart';
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

  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved mail', email);
  }

  @override
  void dispose() {
    MailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  void register() async {
    try {
      await authService.value.createAccount(
        email: MailController.text,
        password: PasswordController.text,
      );
      await saveEmail(MailController.text);
      next();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "There is an error";
      });
    }
  }

  void next() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Usernamepage()),
    );
  }

  void popPage() {
    Navigator.pop(context);
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
                  height: height * 0.3,
                  child: Lottie.asset("lib/assets/lottie/register.json"),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    label: Text(
                      "Enter your mail",
                      style: TextStyle(color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: MailController,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Icon(Icons.key, color: Colors.black),
                    ),
                    label: Text(
                      "Enter your password",
                      style: TextStyle(color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: PasswordController,
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                Text(errorMessage, style: TextStyle(color: Colors.red)),
                SizedBox(height: 10.0),

                SizedBox(
                  width: width,
                  height: height * 0.05,
                  child: ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: width * 0.06,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF673AB7),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),

                Text.rich(
                  TextSpan(
                    text: "Already registered?  ",
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
                                builder: (context) => Loginpage(),
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
