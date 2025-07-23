import 'package:flutter/material.dart';
import 'package:kitaphana/pages/MainPage.dart';
import 'package:kitaphana/pages/ResetPassword.dart';
import 'package:kitaphana/services/auth_service.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Usernamepage extends StatefulWidget {
  const Usernamepage({super.key});

  @override
  State<Usernamepage> createState() => _UsernamepageState();
}

class _UsernamepageState extends State<Usernamepage> {
  TextEditingController UsernameController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  void Update() async {
    try {
      await authService.value.UpdateUsername(username: UsernameController.text);
      await saveUsername(UsernameController.text);
      success();
      next();
    } catch (e) {
      failer();
    }
  }

  void next() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Mainpage()),
    );
  }

  void success() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        content: Text("Gutlayan"),
      ),
    );
  }

  

  void failer() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        content: Text("Bolmady"),
      ),
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
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width,
                    height: height*0.3,
                    child: Lottie.asset("lib/assets/lottie/profile.json")),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: InputDecoration(
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Icon(Icons.person, color: Colors.black,),
                      ),
                      label: Text("Write Your Username"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                    controller: UsernameController,
                  ),
                  SizedBox(height: 10.0,),
                  SizedBox(
                    width: width,
                    height: height*0.05,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          Update();
                        }
                      },
                      child: Text("Create", style: TextStyle(color: Colors.white, fontSize: width*0.06, fontWeight: FontWeight.bold),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple
                      ),
                    ),
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
