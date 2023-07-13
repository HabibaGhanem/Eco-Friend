import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Services/FileStore.dart';
import 'HomeScreen.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}
class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _key = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _db = new Database();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                  const SizedBox(height: 70),
                  const Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please enter your email address to reset your password.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),

                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      //suffixIcon: Icon(Icons.people),
                        labelText: "Enter your email"),
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    //height: 50,
                    width: size.width,
                    child:ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan.shade800, // Background color
                    ),
                      child: Text('Reset your password'),
                    onPressed: () async {
                      if (_key.currentState!.validate()) {

                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: _emailController.text)
                            .catchError((error){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(error.toString())));
                        });

                      }
                    },

                  ),)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}