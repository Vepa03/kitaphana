import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitaphana/pages/AboutUs.dart';
import 'package:kitaphana/pages/RegistrationPage.dart';
import 'package:kitaphana/services/auth_service.dart';
import 'package:lottie/lottie.dart';

class Adminpage extends StatefulWidget {
  const Adminpage({super.key});

  @override
  State<Adminpage> createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  String errorMessage = '';

  void logout() async {
    try {
      await authService.value.signOut();
      next();
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message ?? "There is an error";
    }
    authService.value.signOut();
  }

  void next() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
      (Route<dynamic> route) => false,
    );
  }

  void logout_allert(){
    showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text('Do you want to Logout ?'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.3,
            height: MediaQuery.of(context).size.height*0.05,
            child: ElevatedButton(onPressed: (){
              logout();
            }, child: Text('Yes', style: TextStyle(fontSize: 20, color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.3,
            height: MediaQuery.of(context).size.height*0.05,
            child: ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('No', style: TextStyle(fontSize: 20, color: Colors.white),), 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    ));
  }


  void delete_allert(){
    showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text('Do you want to Delete your account ?'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.3,
            height: MediaQuery.of(context).size.height*0.05,
            child: ElevatedButton(onPressed: (){
              
            }, child: Text('Yes', style: TextStyle(fontSize: 20, color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.3,
            height: MediaQuery.of(context).size.height*0.05,
            child: ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('No', style: TextStyle(fontSize: 20, color: Colors.white),), 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Admin"), backgroundColor: Colors.amber),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  height: height*0.3,
                  child: Lottie.asset("lib/assets/lottie/admin.json")),
                Text("Username: ${authService.value.currentUser!.displayName }" ?? "No Username", style: TextStyle(fontSize: width*0.06),),
                SizedBox(height: 20.0,),
                Divider(color: Colors.black12,),
                Text("Settings", style: TextStyle(fontSize: width*0.07, fontWeight: FontWeight.bold),),
                ListTile(
                  title: Text("Update Username", style: TextStyle(color: Colors.black, fontSize: width*0.045),),
                  onTap: (){
                
                  },
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.black,),
                ),
                ListTile(
                  title: Text("Change Password", style: TextStyle(color: Colors.black, fontSize: width*0.045),),
                  onTap: (){
                
                  },
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.black,),
                ),
                ListTile(
                  title: Text("Delet Account", style: TextStyle(color: Colors.black, fontSize: width*0.045),),
                  onTap: (){
                    delete_allert();
                  },
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.black,),
                ),
                ListTile(
                  title: Text("About this app", style: TextStyle(color: Colors.black, fontSize: width*0.045),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Aboutus()));
                  }
                ),
                ListTile(
                  title: Text("Logout", style: TextStyle(color: Colors.red, fontSize: width*0.045, fontWeight: FontWeight.bold),),
                  onTap: (){
                    logout_allert();
                  }
                ),
                
                SizedBox(height: 30.0),
                Text(errorMessage, style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
