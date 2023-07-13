import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/Calculator.dart';
import 'package:graduation_project_app/ResetPasswordScreen.dart';
import 'package:graduation_project_app/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CurrentUserData.dart';
import 'Services/Auth.dart';
import 'Services/FileStore.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Auth _auth=new Auth();
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isPassword = true;
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();

  late SharedPreferences _preferences;
  saveData() async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setStringList('currentAccount', [_emailAddressController.text, _passwordController.text]);
  }
  getData()async{
      _preferences = await SharedPreferences.getInstance();
      List? accountData = _preferences.get('currentAccount') as List?;
      if (accountData!.isNotEmpty) {
        setState(() {
          _emailAddressController.text = accountData[0];
          _passwordController.text = accountData[1];
          rememberMe = true;
        });
      }

  }

  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    double scwidth = MediaQuery.of(context).size.width;
    double scheight = MediaQuery.of(context).size.height;
    if (_emailAddressController.text.isEmpty && rememberMe) {
      getData();
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: scheight,
          width: scwidth,
          padding: const EdgeInsets.only(top: 100),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Image(
                  image: NetworkImage('https://lancashire3d.uk/wp-content/uploads/2019/10/l3decopart4-300x277.jpg'),
                  height:80,
                  width:80,
                  fit: BoxFit.cover
                ),
            /*Text(
              'Login',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),*/
            Form(key: _formKey, child:
            Stack(
                alignment: Alignment(0, 1.15),
              children: [
            Container(
            margin:EdgeInsets.only(left:20,top:60,right:20),
              padding: const EdgeInsets.only(left:12.0,right: 12.0,top:30.0),
              height:scheight*0.40,
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 0.1,
                      blurRadius: 5,
                    )
                  ]),
              child: Column(
                children: [
                  TextFormField(
                      controller: _emailAddressController,
                      decoration: InputDecoration(
                        //suffixIcon: Icon(Icons.people),
                          labelText: "Email address"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                      }),
                  SizedBox(height: 10,),
                  TextFormField(obscureText: isPassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  isPassword= !isPassword;
                                });
                              },
                              icon: Icon(isPassword?Icons.visibility:Icons.visibility_off)
                          ),
                          labelText: "Password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                      }),
                  SizedBox(height: 4,),

                  Row(
                    //mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      SizedBox(
                        width:17,
                        child: Transform.scale(
                          scale: 0.8,
                          child: Checkbox(

                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value as bool;
                                });
                              }),
                        ),
                      ),

                      Text(
                        " Remember me",
                          style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(
                        width:105
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen()));
                          },
                          child: Text(
                            "Forgotten Password?",
                            style: TextStyle(
                              color: Colors.cyan.shade900,
                             fontSize: 12,
                              //decoration: TextDecoration.underline,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
                SizedBox(
                  //height: 50,
                  width: 110,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                            primary: Colors.cyan.shade800, // Background color
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                                  //TODO authenticate user
                                  await _auth.SignIn(_emailAddressController.text, _passwordController.text).then((value)async{
                                    if(value==true)
                                    {
                                      if(rememberMe){
                                        await saveData();
                                      }

                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success")));

                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("failed")));

                                    }
                                  });

                            }

                          }
                          , child: Text("Log in"),
                        ),
                ),
              ])
            ),
                SizedBox(height: 150,),
                Container(
                  margin: EdgeInsets.only(right:11 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ",
                      style: TextStyle(fontSize: 12),),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              color: Colors.cyan.shade900,
                                decoration: TextDecoration.underline,
                              fontSize: 12
                              //decoration: TextDecoration.underline,
                            ),
                          ))
                    ],
                  ),
                ),
          ]),
        ),
      ),
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var controlPoint1 = Offset(size.width * 0.05, size.height * 0.47);
    var endPoint1 = Offset(size.width * 0.1, size.height * 0.45);
    Path path = Path();
    path.moveTo(size.width * 0.05, size.height * 0.5);
    path.quadraticBezierTo(
        controlPoint1.dx, controlPoint1.dy, endPoint1.dx, endPoint1.dy);
    path.lineTo(size.width * 0.8, size.height / 3);
    path.quadraticBezierTo(size.width * 0.93, size.height / 3.4,
        size.width * 0.95, size.height / 2.8);
    path.lineTo(size.width * 0.95, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
