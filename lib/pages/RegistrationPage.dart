import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
  
}

class _RegistrationPageState extends State<RegistrationPage> {

  TextEditingController MailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          TextFormField(
            decoration: InputDecoration(
              prefix: Icon(Icons.person),
              label: Text("Write Your Password"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            controller: MailController,
            obscureText: true,
          )
        ],
      ),
    );
  }
}