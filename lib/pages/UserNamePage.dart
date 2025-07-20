import 'package:flutter/material.dart';
import 'package:kitaphana/pages/MainPage.dart';
import 'package:kitaphana/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Usernamepage extends StatefulWidget {
  const Usernamepage({super.key});

  @override
  State<Usernamepage> createState() => _UsernamepageState();
}

class _UsernamepageState extends State<Usernamepage> {

  TextEditingController UsernameController = TextEditingController();

  Future <void> saveUsername(String  username) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }


  void Update() async{
    try {
      await authService.value.UpdateUsername(username: UsernameController.text);
      await saveUsername(UsernameController.text);
      success();
      next();
    } catch (e) {
      failer();
    }
  }

  void next(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Mainpage()));
  }

  void success(){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        content: Text("Gutlayan"))
    );
  }
  void failer(){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        content: Text("Bolmady"))
    );
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
                  label: Text("Write Your Username"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                controller: UsernameController,
                obscureText: true,
              ),
              ElevatedButton(onPressed: (){
                Update();
              }, child: Text("Update"))
          ],
        ),
      ),
    );
  }
}