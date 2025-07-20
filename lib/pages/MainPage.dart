import 'package:flutter/material.dart';
import 'package:kitaphana/pages/AdminPage.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Adminpage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.person, color: Colors.black),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text("Main Page"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Welcome')],
      ),
      backgroundColor: Colors.white,
    );
  }
}
