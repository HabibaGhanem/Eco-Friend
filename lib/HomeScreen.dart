import 'package:flutter/material.dart';
import 'package:graduation_project_app/CurrentUserData.dart';
import 'package:graduation_project_app/HabitsPage.dart';
import 'package:graduation_project_app/login_screen.dart';
import '../Services/FileStore.dart';
import 'Tips.dart';
import 'package:graduation_project_app/Navigation%20bar.dart';
import '../habits.dart';
import 'HabitsMainPage.dart';
import 'package:google_fonts/google_fonts.dart';


String? username;
double?cf;
class Homescreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Homescreen> {
  Database _db = new Database();
  List<double>? uCF;
  getUserHabits(String uID) async {
    await _db.UserHabitRef.where('userID', isEqualTo: uID).get().then((value){
      for(int i = 0; i < value.docs.length; i++){
        String id = value.docs[i].get('habitID');//
        DateTime sDate = DateTime.parse(value.docs[i].get('startDate'));
        String? title;
        _db.getHabitTitle(id).then((value){
          title = value;
          setState(() {
            if(!selected.any((element) => element.name == title)) {
              selected.add(habits(title!, false, int.parse(id)));
            }
            startDateMap[id] = sDate;//
            print("start date   "+sDate.toString()+"added for:  "+id);
          });
        });
      }
    });
  }
  getuser(){
    _db.getUsername(UserData.userID!).then((value){
      setState((){
        username = value;
      });
    });
  }
  bool loaded = false;
  @override
  void initState() {
    super.initState();
    _db.getCFofUser(UserData.userID!).then((value){
      setState(() {
        remove();
        add('electricity',value[12], 'Unplug the plug');
        add('meat', value[0], 'Eat a pescatarian meal');
        add('gas', value[1], 'Cook with stove off / turn off stove first');
        //add('car', value[2], 'Get around with public transport');
        add('car', value[2], 'Carpool');
        add('short flight', value[3], 'Take the train instead of the plane');
        add('long flight', value[4], 'Travel locally');
        add('chicken, seafood, or eggs', value[5], 'Eat a vegetarian meal');
        add('living space', value[6], 'Share your home');
        add('milk, cheese, or other dairy products', value[7], 'Eat a vegan meal');
        add('Spending on furniture and appliances', value[8], 'Choose second-hand furniture');
        add('Traveling by bus',value[9], 'Ride a bike instead of public transport');
        add('clothes',value[11], 'Choose secondhand clothes');

        if(value.length==13){
          cf = value[10];
          loaded=true;
        }
      });

    });
    getuser();
    getUserHabits(UserData.userID!);
  }
  @override
  Widget build(BuildContext context) {

    final Tips tipp;



    return  Scaffold(
      bottomNavigationBar: buildMyNavBar(context),
      appBar: AppBar(

        backgroundColor: Colors.cyan.shade800,

        toolbarHeight: 100,

        elevation: 14,

        shape: RoundedRectangleBorder(

            borderRadius:

            BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40))

        ),

        title: Text('Eco Friend',
        style: GoogleFonts.getFont('Quando',
         fontSize: 23,
        )),

        actions: [

          Row(

            children: [


              SizedBox(width: 30,), Container(

                height: 40,
                width: 40,

                alignment: Alignment.center,

                decoration: BoxDecoration(

                  boxShadow: [

                    BoxShadow(blurRadius: 7, spreadRadius: 3,

                        color: Color(0xFFADD8E6)

                    )

                  ],

                  shape: BoxShape.circle,

                  color: Colors.cyan.shade900,

                ),

                child: InkWell(
                  child: Icon(Icons.logout, size: 20,

                  ),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                  },
                ),

              ),

              SizedBox(width: 26,)

            ],

          )

        ],

      ),
      body: SingleChildScrollView(
        child: Column(

          children:[
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20,),
                Text('Tips',style: GoogleFonts.getFont('Quando',
                  fontSize: 20,fontWeight: FontWeight.bold,color: Colors.cyan.shade900
                )

                ),
              ],
            ),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row( children: Tips_list.map((tip) => buildcontunier ( context , tip)).toList(),
              ),
            ),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20,),
                Text('Recommendations',

                    style: GoogleFonts.getFont('Quando',
                        fontSize: 20,fontWeight: FontWeight.bold,color: Colors.cyan.shade900
                    )

                ),
                /*SizedBox(width: 100,),
                ElevatedButton(onPressed: (){
                  print("Go To Habits");
                },
                    child:Text('more'),
                    //Icon(Icons.more_horiz_sharp) ,

                    style: ElevatedButton.styleFrom(
                      primary:Color(0xFF338BA8) ,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),)
                )*/
              ],
            ),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: loaded?Row( children: recoList.map((habit) => buildcontunier2 ( context , habit)).toList(),):
              Center(child: CircularProgressIndicator()),
            ),
          ],

        ),
      ),
    );
  }

}
Widget buildcontunier(BuildContext context,Tips tip){
  return   GestureDetector(

    child: Row(
      children: [
        SizedBox(width: 10,),
        Container(
          height: 220,
          width: 300,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [ BoxShadow(
              color: Colors.grey,
              offset: const Offset(
                2.0,
                2.0,
              ),
              blurRadius: 6.0,
              spreadRadius: 1.0,
            ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],

          ),

          child: Row(
            children: [
              Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 200,
                      width: 270,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(tip.image),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(20)

                      ),
                    ),
                  ),
                  SizedBox(height: 3,),
                  Text(
                    tip.name,
                      style: GoogleFonts.getFont('Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.w900
                      )

                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),

  );
}
Widget buildcontunier2(BuildContext context,Recommendation habit){   /////////////////////////////////////////
  return   GestureDetector(

    child: Row(
      children: [
        SizedBox(width: 10,),
        Container(
          height: 220,
          width: 300,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [ BoxShadow(
              color: Colors.grey,
              offset: const Offset(
                2.0,
                2.0,
              ),
              blurRadius: 6.0,
              spreadRadius: 1.0,
            ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],

          ),

          child: Row(
            children: [
              Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 270,
                      width: 270,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(habit.image),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(20)

                      ),
                    ),
                  ),
                  SizedBox(height: 3,),
                  Text(
                    habit.name,
                      style: GoogleFonts.getFont('Lato',
                        fontSize: 15,
                        fontWeight: FontWeight.w900
                      )


                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
