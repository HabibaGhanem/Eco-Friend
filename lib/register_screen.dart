import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/User.dart';
import 'package:graduation_project_app/Calculator.dart';
import 'package:graduation_project_app/login_screen.dart';
import 'package:intl/intl.dart';
import 'package:age_calculator/age_calculator.dart';

import 'Services/Auth.dart';
import 'Services/FileStore.dart';



class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _DateController = TextEditingController();
  Auth _auth=new Auth();
  DateTime? birthdate;
  bool isPassword = true;
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  int _groupValue = 0;
  Database _db = new Database();
  @override
  void dispose(){
    _DateController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _emailAddressController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double scwidth = MediaQuery.of(context).size.width;
    double scheight = MediaQuery.of(context).size.height;

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
                alignment: Alignment(0, 1.12),
                children: [
                  Container(
                    margin:EdgeInsets.only(left:20,top:60,right:20),
                    padding: const EdgeInsets.only(left:12.0,right: 12.0,top:30.0),
                    height:scheight*0.55,
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
                            controller: _usernameController,
                            decoration: InputDecoration(
                              //suffixIcon: Icon(Icons.people),
                                labelText: "Username"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                            }),
                        SizedBox(height: 10,),
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
                        TextFormField(
                           obscureText: isPassword,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                                hintText: "Password should be at least 6 characters",
                                hintStyle: TextStyle(
                                  fontSize: 11
                                ),
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      isPassword= !isPassword;
                                    });
                                  },
                                    icon: Icon(isPassword?Icons.visibility:Icons.visibility_off)
                                ),
                                //hintText: "Password.."
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the password';
                              }
                            }),
                        SizedBox(height: 10,),

                        TextFormField(
                            controller: _DateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.calendar_today),
                                labelText: "Date of birth"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your birthdate';
                              }
                            },
                        onTap: ()async{
                              DateTime? pickedDate=await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(), firstDate: DateTime(1950),
                                  lastDate: DateTime.now()).then((value){
                   setState(() {

                     birthdate = value!;
                     _DateController.text=DateFormat.yMMMd().format(value!);

                   });
                 });
                              },),
                        SizedBox(height: 10,),
                    Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children:[
                 Text("  Gender : ", style:  TextStyle(fontSize: 20),),
                 Radio(value: 0, groupValue: _groupValue, onChanged: (value){
                   setState(() {
                     _groupValue=value as int;
                   });
                 }),
                 Text("Male", style:  TextStyle(fontSize: 18),),
                 Radio(value: 1, groupValue: _groupValue, onChanged: (value){
                   setState(() {
                     _groupValue=value as int;
                   });
                 }),
                 Text("Female", style:  TextStyle(fontSize: 18),),
               ]
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
                        if (_formKey.currentState!.validate()
                        ) {
                          DateDuration duration;
                          duration = AgeCalculator.age(birthdate!);

                            await _auth.SignUp(_emailAddressController.text,
                            _passwordController.text)
                                .then((value) {
                            if (value != Null) {
                          _db.SaveAccount(Account(
                            userID: value,
                            username: _usernameController.text,
                            email : _emailAddressController.text,
                            birthdate : _DateController.text,
                            age: duration.years,
                            gender : _groupValue == 0?"Male": "Female"));

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Success")));
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("failed")));
                            }
                            });
                        }

                      }
                      , child: Text("Sign up"),
                    ),
                  ),
                ])
            ),
            SizedBox(height: 45,),
            Container(
              margin: EdgeInsets.only(right:11 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ",
                    style: TextStyle(fontSize: 12),),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: Text(
                        "Log in",
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
