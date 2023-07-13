import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/login_screen.dart';
import 'package:graduation_project_app/News_screen.dart';
import 'package:graduation_project_app/HabitsPage.dart';
import 'package:graduation_project_app/HabitsMainPage.dart';
import 'package:graduation_project_app/register_screen.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project_app/HomeScreen.dart';
import 'package:dcdg/dcdg.dart';

import 'Calculator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp()); //function btakhod widget
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {

  final int _numpages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentpage = 0;
  List<Widget> _buildPageIndicator() {
    List<Widget> list=[];
    for(int i=0; i<_numpages; i++){
      list.add(i==_currentpage ? _indicator(true):_indicator(false));
    }
    return list;
  }
  Widget _indicator(bool isActive){
    return AnimatedContainer(duration: Duration(microseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Color(0xFF338BA8),
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(decoration:
        BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: [
              Color(0xFFFEFEFA),
              Color(0xFFADD8E6),
              Color(0xFF338BA8),
              Color(0xFF296E85),


            ],),


        ),
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () { Navigator.push(context, MaterialPageRoute(builder:(context)=> LoginScreen() ));  },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 600,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentpage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding:  EdgeInsets.all(40.0),
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(image: AssetImage('assets/calccarbon.png'),
                                height: 300,
                                width: 300,),
                            ),
                            SizedBox(height: 30,),
                            Text(
                              "Calculate Your Carbon Footprint",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 26),),
                            SizedBox(height: 15,),
                            Text(
                              "calculator helps you to find out how much carbon your habits produce.",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),)
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.all(40.0),
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(image: AssetImage('assets/hab.png'),
                                height: 300,
                                width: 300,),
                            ),
                            SizedBox(height: 30,),
                            Text(
                              "Change your habits and Track them",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 26),),
                            SizedBox(height: 15,),
                            Text(
                              "you have the ability to reduce your carbon footprint by changing some of your habits that harm the environment "
                                  "like your Eating habits or travaling ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),)
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.all(40.0),
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(image: AssetImage('assets/tip.png'),
                                height: 300,
                                width: 300,),
                            ),
                            SizedBox(height: 30,),
                            Text(
                              "Stay up to date with climate news",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 26),),
                            SizedBox(height: 15,),
                            Text(
                              "Know what is new in the climate change subject around thq world",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),)
                          ],
                        ),
                      ),
                    ],
                  ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:_buildPageIndicator() ,
                ),
                _currentpage != _numpages-1
                    ? Expanded(child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: TextButton(
                    onPressed: (){
                      _pageController.nextPage(duration: Duration(microseconds: 500), curve: Curves.ease);

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children:<Widget> [
                        Text(
                          "Next",
                          style: TextStyle(color: Colors.white,fontSize: 22),
                        ),
                        SizedBox(width: 10,),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                )
                ): Text(' '),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentpage == _numpages -1
          ?Container(
        height: 100,
        width: double.infinity,
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:(context)=> LoginScreen() ));
          } ,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                'Get Started',
                style: TextStyle(color:  Color(0xFF296E85),fontSize: 20,fontWeight: FontWeight.bold),

              ),
            ),
          ),
        ),
      ): Text(' '),
    );

  }
}
