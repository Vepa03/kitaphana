import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitaphana/pages/MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kitaphana/pages/Adminpage.dart';
import 'package:kitaphana/pages/RegistrationPage.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved mail');

    if (user != null && savedEmail != null) {
      // Kullanıcı oturumu var → Adminpage'e git
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Mainpage()),
      );
    } else {
      // Kullanıcı yok → RegistrationPage'e git
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegistrationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // loading animasyonu
      ),
    );
  }
}
