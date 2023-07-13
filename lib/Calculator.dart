import 'dart:ffi';

import 'package:graduation_project_app/CarbonFootprint.dart';
import 'package:graduation_project_app/Services/FileStore.dart';

import 'package:graduation_project_app/CurrentUserData.dart';

import 'package:flutter/material.dart';
import 'Data.dart';
import 'News_Screen.dart';
import 'Optionpage.dart';
import 'Results page.dart';
import 'HomeScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:graduation_project_app/Navigation%20bar.dart';
import 'package:google_fonts/google_fonts.dart';


Database _db = new Database();
double? CFValue;

class MyApp extends StatelessWidget{

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    home: SafeArea(
      child: DefaultTabController(length: 7,
        child:Scaffold(
        bottomNavigationBar: buildMyNavBar(context),backgroundColor: Colors.white,
          appBar:  AppBar(
            backgroundColor:Colors.cyan.shade800
            ,

            toolbarHeight: 70,

            elevation: 14,

            /*shape: RoundedRectangleBorder(

                borderRadius:

                BorderRadius.only(
                    bottomRight: Radius.circular(70),
                    bottomLeft: Radius.circular(70))

            ),*/



            /*actions: [

              Row(

                children: [


                  SizedBox(width: 10,),
                  Container(

                    height: 40,
                    width: 40,

                    alignment: Alignment.center,

                    decoration: BoxDecoration(

                      boxShadow: [

                        BoxShadow(blurRadius: 7, spreadRadius: 3,

                            color: Colors.purple.shade300

                        )

                      ],

                      shape: BoxShape.circle,

                      color: Colors.purple.shade400,

                    ),

                    child: Icon(Icons.notifications_active, size: 20,

                    ),

                  ),

                  SizedBox(width: 10,), Container(

                    height: 40,
                    width: 40,

                    alignment: Alignment.center,

                    decoration: BoxDecoration(

                      boxShadow: [

                        BoxShadow(blurRadius: 7, spreadRadius: 3,

                            color: Colors.purple.shade300,

                        )

                      ],

                      shape: BoxShape.circle,

                      color: Colors.purple.shade400,


                    ),

                    child: Icon(Icons.logout, size: 20,

                    ),

                  ),

                  SizedBox(width: 26,)

                ],

              )

            ],*/

            bottom: TabBar( isScrollable: true,
                indicatorColor: Colors.white,
                indicatorWeight: 5,
                tabs: [
              Tab(icon: Icon(Icons.directions_car_filled_outlined)),
              Tab(icon: Icon(Icons.local_airport_outlined)),
              Tab(icon: Icon(Icons.directions_bus_filled_outlined)),
              Tab(icon: Icon(Icons.set_meal_outlined)),
                  Tab(icon: Icon(Icons.pets_outlined)),
              Tab(icon: Icon(Icons.shopping_bag_outlined)),
              Tab(icon: Icon(Icons.house_outlined)),


            ]),

            title: Text("Carbon Footprint Calculator",
                style: GoogleFonts.getFont('Quando',
                  fontSize: 20,
                )) ,

          ),

          body:
          Container(
              color:Color(0xFFf9f2ec),
            child: TabBarView(
              children: [
                carQuestionWidget(),
                airportQuestionWidget(),
                transportsQuestionWidget(),
                mealQuestionWidget(),
                petQuestionWidget(),
                shoppingQuestionWidget(),
                houseQuestionWidget(),

              ],
            ),
          ),
        ) ,
      ),
    ),
    );
  }
}
int index=0;
List<double> store = List.filled(20,0.0);
class carQuestionWidget extends StatefulWidget{
  State<StatefulWidget> createState(){
    return carQuestionWidgetstate();
  }
}

// create question
class carQuestionWidgetstate extends State<carQuestionWidget> {
  late PageController controller;
  int questionnum=1;
  @override
  void initState() {
    // TODO: implement initStateg
    super.initState();
    controller=PageController(initialPage: 0);
  }
  @ override
  //build question and question numbering
  Widget build(BuildContext context){

    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30,),
          Text('Question $questionnum / ${carquestions.length} ',
            style: GoogleFonts.getFont('Quando',fontWeight: FontWeight.bold,
              fontSize: 26,color: Colors.cyan.shade900
            ),),
          const Divider(thickness: 1, color:Color(0xFF006064),),
          Expanded(
            child: PageView.builder(
              itemCount: carquestions.length,
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final __question = carquestions[index];
                return buildquestion(__question);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              buildbackFloatingActionButton(),
              SizedBox(width: 10,),
              questionnum<carquestions.length?buildFloatingActionButton():SizedBox(width: 5,),


            ],
          ),
          const SizedBox(height: 20,),

        ],
      ),
    );

  }
// question still and set option
  Widget buildquestion(Question question) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 32,),
          Text(
            question.text,
            style: GoogleFonts.getFont('Lato',
            fontSize: 25,//fontWeight: FontWeight.bold
          ) ,
          ),
          const SizedBox(height: 32,),
          Expanded(child:  OptionWidget(
              question :question,
              OnClickedOption : (option){

                if (question.isLocked) {
                  return;
                }
                else {
                  setState(() {
                    question.isLocked = true;
                    question.selectedOption = option;
                    print(index);
                    print(option.num);
                    store[index]=option.num;
                    index++;
                    print(index);
                  });
                };

                  if (questionnum<carquestions.length ){
                    controller.nextPage(duration: const Duration(milliseconds:200 ), curve: Curves.easeInExpo);
                    setState(() {
                      questionnum++;


                    });
                  };

              }
          )
          )
        ],
      ),
    );

  }
  FloatingActionButton buildbackFloatingActionButton() {
    return FloatingActionButton(onPressed: () {
      if (questionnum != 0) {
        controller.previousPage(duration: const Duration(milliseconds: 200),
            curve: Curves.easeInExpo);
        setState(() {
          questionnum--;
        });
      }
      else {

      }
    },
      backgroundColor: Colors.cyan.shade800,

      child: Icon(
          Icons.navigate_before

      ),


    );
  }
    FloatingActionButton buildFloatingActionButton() {
      return FloatingActionButton(onPressed: () {
        if (questionnum<carquestions.length){
          controller.nextPage(duration: const Duration(milliseconds:200 ), curve: Curves.easeInExpo);
          setState(() {
            questionnum++;

          });
        };
      },
      backgroundColor: Colors.cyan.shade800,

      child: Icon(
      Icons.navigate_next

      ),
      );
    }
  }


class airportQuestionWidget extends StatefulWidget{
  State<StatefulWidget> createState(){
    return airportQuestionWidgetstate();
  }
}
// create question
class airportQuestionWidgetstate extends State<airportQuestionWidget> {
  late PageController controller;
  late TabController tapcont;
  int questionnum = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  //build question and question numbering
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30,),
          Text('Question $questionnum / ${flightsquestions.length} ',
            style: GoogleFonts.getFont('Quando',fontWeight: FontWeight.bold,
                fontSize: 26,color: Colors.cyan.shade900
            ),),
          const Divider(thickness: 1, color: Color(0xFF006064),),
          Expanded(
            child: PageView.builder(
              itemCount: flightsquestions.length,
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final __question = flightsquestions[index];
                return buildquestion(__question);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              buildbackFloatingActionButton(),
              SizedBox(width: 10,),
              questionnum<flightsquestions.length?buildFloatingActionButton():SizedBox(width: 5,),
            ],
          ),

          const SizedBox(height: 20,),

        ],
      ),
    );
  }

// question still and set option
  Widget buildquestion(Question question) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 32,),
          Text(
            question.text,
              style: GoogleFonts.getFont('Lato',
                fontSize: 25,//fontWeight: FontWeight.bold
              ) ,
          ),
          const SizedBox(height: 32,),
          Expanded(child: OptionWidget(
              question: question,

              OnClickedOption: (option) {

                if (question.isLocked) {
                  return;
                }
                else {
                  setState(() {
                    question.isLocked = true;
                    question.selectedOption = option;
                    // question.store![question.index]=option.toString();
                    print(index);
                    print(option.num);
                    store[index]=option.num;
                    index++;
                    print(index);
                  });
                };
                if (questionnum < flightsquestions.length) {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInExpo);
                   setState(() {
                    questionnum++;

                  });
                };

              }
          )
          )
        ],
      ),
    );
  }

  FloatingActionButton buildbackFloatingActionButton() {
    return FloatingActionButton(onPressed: () {
      if (questionnum != 0) {
        controller.previousPage(duration: const Duration(milliseconds: 200),
            curve: Curves.easeInExpo);
        setState(() {
          questionnum--;
        });
      }
      else {

      }
    },
      backgroundColor:Colors.cyan.shade800,

      child: Icon(
          Icons.navigate_before

      ),


    );
  }
  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(onPressed: () {
      if (questionnum<flightsquestions.length ){
        controller.nextPage(duration: const Duration(milliseconds:200 ), curve: Curves.easeInExpo);
        setState(() {
          questionnum++;

        });
      };
    },
      backgroundColor: Colors.cyan.shade800,

      child: Icon(
          Icons.navigate_next

      ),
    );
  }
}

class transportsQuestionWidget extends StatefulWidget{
  State<StatefulWidget> createState(){
    return transportsQuestionWidgetstate();
  }
}
// create question
class transportsQuestionWidgetstate extends State<transportsQuestionWidget> {
  late PageController controller;
  int questionnum=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=PageController(initialPage: 0);
  }
  @ override
  //build question and question numbering
  Widget build(BuildContext context){

    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30,),
          Text('Question $questionnum / ${transportsquestions.length} ',
            style: GoogleFonts.getFont('Quando',fontWeight: FontWeight.bold,
                fontSize: 26,color: Colors.cyan.shade900
            ),),
          const Divider(thickness: 1, color: Color(0xFF006064),),
          Expanded(
            child: PageView.builder(
              itemCount: transportsquestions.length,
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final __question = transportsquestions[index];
                return buildquestion(__question);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [


              buildbackFloatingActionButton(),
              SizedBox(width: 10,),
              questionnum<transportsquestions.length?buildFloatingActionButton():SizedBox(width: 5,),
            ],
          ),

          const SizedBox(height: 20,),

        ],
      ),
    );

  }
// question still and set option
  Widget buildquestion(Question question) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 32,),
          Text(
            question.text,
              style: GoogleFonts.getFont('Lato',
                fontSize: 25,//fontWeight: FontWeight.bold
              ) ,
          ),
          const SizedBox(height: 32,),
          Expanded(child:  OptionWidget(
              question :question,
              OnClickedOption : (option){

                if(question.isLocked){
                  return;
                }
                else{
                  setState(() {
                    question.isLocked = true;
                    question.selectedOption = option;
                    //question.store![question.index]=option.toString();
                    print(index);
                    print(option.num);
                    store[index]=option.num;
                    index++;
                    print(index);

                  });
                };
                if (questionnum<transportsquestions.length ){
                  controller.nextPage(duration: const Duration(milliseconds:200 ), curve: Curves.easeInExpo);
                  setState(() {
                    questionnum++;

                  });
                };
              }
          )
          )
        ],
      ),
    );

  }

  FloatingActionButton buildbackFloatingActionButton() {
    return FloatingActionButton(onPressed: () {
      if (questionnum != 0) {
        controller.previousPage(duration: const Duration(milliseconds: 200),
            curve: Curves.easeInExpo);
        setState(() {
          questionnum--;
        });
      }
      else {

      }
    },
      backgroundColor: Colors.cyan.shade800,

      child: Icon(
          Icons.navigate_before

      ),


    );
  }
  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(onPressed: () {
      if (questionnum<transportsquestions.length){
        controller.nextPage(duration: const Duration(milliseconds:200 ), curve: Curves.easeInExpo);
        setState(() {
          questionnum++;

        });
      };
    },
      backgroundColor: Colors.cyan.shade800,

      child: Icon(
          Icons.navigate_next

      ),
    );
  }

}
class mealQuestionWidget extends StatefulWidget{
  State<StatefulWidget> createState(){
    return mealQuestionWidgetstate();
  }
}
// create question
class mealQuestionWidgetstate extends State<mealQuestionWidget> {
  late PageController controller;
  int questionnum=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=PageController(initialPage: 0);
  }
  @ override
  //build question and question numbering
  Widget build(BuildContext context){

    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30,),
          Text('Question $questionnum / ${foodquestions.length} ',
            style: GoogleFonts.getFont('Quando',fontWeight: FontWeight.bold,
                fontSize: 26,color: Colors.cyan.shade900
            ),),
          const Divider(thickness: 1, color: Color(0xFF006064),),
          Expanded(
            child: PageView.builder(
              itemCount: foodquestions.length,
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final __question = foodquestions[index];
                return buildquestion(__question);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [


              buildbackFloatingActionButton(),
              SizedBox(width: 10,),
              questionnum<foodquestions.length?buildFloatingActionButton():SizedBox(width: 5,),
            ],
          ),

          const SizedBox(height: 20,),

        ],
      ),
    );

  }
// question still and set option
  Widget buildquestion(Question question) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 32,),
          Text(
            question.text,
            style: GoogleFonts.getFont('Lato',
              fontSize: 25,//fontWeight: FontWeight.bold
            ) ,
          ),
          const SizedBox(height: 32,),
          Expanded(child:  OptionWidget(
              question :question,
              OnClickedOption : (option) {

                if (question.isLocked) {
                  return;
                }
                else {
                  setState(() {
                    question.isLocked = true;
                    question.selectedOption = option;
                    //question.store![question.index]=option.toString();
                    print(index);
                    print(option.num);
                    store[index]=option.num;
                    index++;
                    print(index);
                  });
                  if (questionnum < foodquestions.length) {
                    controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInExpo);
                    setState(() {
                      questionnum++;

                    });
                  };
                }
              }
          )
          )
        ],
      ),
    );

  }


  FloatingActionButton buildbackFloatingActionButton() {
    return FloatingActionButton(onPressed: () {
      if (questionnum != 0) {
        controller.previousPage(duration: const Duration(milliseconds: 200),
            curve: Curves.easeInExpo);
        setState(() {
          questionnum--;
        });
      }
      else {

      }
    },
      backgroundColor: Colors.cyan.shade800,

      child: Icon(
          Icons.navigate_before

      ),


    );
  }
  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(onPressed: () {
      if (questionnum<foodquestions.length){
        controller.nextPage(duration: const Duration(milliseconds:200 ), curve: Curves.easeInExpo);
        setState(() {
          questionnum++;

        });
      };
    },
      backgroundColor: Colors.cyan.shade800,

      child: Icon(
          Icons.navigate_next

      ),
    );
  }
}

class shoppingQuestionWidget extends StatefulWidget{
  State<StatefulWidget> createState(){
    return shoppingQuestionWidgetstate();
  }
}
// create question
class shoppingQuestionWidgetstate extends State<shoppingQuestionWidget> {
  late PageController controller;
  int questionnum=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=PageController(initialPage: 0);
  }
  @ override
  //build question and question numbering
  Widget build(BuildContext context){

    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30,),
          Text('Question $questionnum / ${shoppingquestions.length} ',
            style: GoogleFonts.getFont('Quando',fontWeight: FontWeight.bold,
                fontSize: 26,color: Colors.cyan.shade900
            ),),
          const Divider(thickness: 1, color: Color(0xFF006064),),
          Expanded(
            child: PageView.builder(
              itemCount: shoppingquestions.length,
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final __question = shoppingquestions[index];
                return buildquestion(__question);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              buildbackFloatingActionButton(),
              SizedBox(width: 10,),
              questionnum<shoppingquestions.length?buildFloatingActionButton():SizedBox(width: 5,),
            ],
          ),

          const SizedBox(height: 20,),

        ],
      ),
    );

  }
// question still and set option
  Widget buildquestion(Question question) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 32,),
          Text(
            question.text,
            style: GoogleFonts.getFont('Lato',
              fontSize: 25,//fontWeight: FontWeight.bold
            ) ,
          ),
          const SizedBox(height: 32,),
          Expanded(child:  OptionWidget(
              question :question,
              OnClickedOption : (option){

                if(question.isLocked){
                  return;
                }

                else{
                  setState(() {
                    question.isLocked = true;
                    question.selectedOption = option;
                    //question.store![question.index]=option.toString();
                    print(index);
                    print(option.num);
                    store[index]=option.num;
                    index++;
                    print(index);
                  });
                };
                if (questionnum<shoppingquestions.length ){
                  controller.nextPage(duration: const Duration(milliseconds:200 ), curve: Curves.easeInExpo);
                  setState(() {
                    questionnum++;

                  });
                } ;
              }
          )
          )
        ],
      ),
    );

  }

  FloatingActionButton buildbackFloatingActionButton() {
    return FloatingActionButton(onPressed: () {
      if (questionnum != 0) {
        controller.previousPage(duration: const Duration(milliseconds: 200),
            curve: Curves.easeInExpo);
        setState(() {
          questionnum--;
        });
      }
      else {

      }
    },
      backgroundColor: Colors.cyan.shade800,

      child: Icon(
          Icons.navigate_before

      ),


    );
  }
  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(onPressed: () {
      if (questionnum<shoppingquestions.length ){
        controller.nextPage(duration: const Duration(milliseconds:200 ), curve: Curves.easeInExpo);
        setState(() {
          questionnum++;

        });
      };
    },
      backgroundColor:Colors.cyan.shade800,

      child: Icon(
          Icons.navigate_next

      ),
    );
  }
}

//late double carbonfootprint = 13.5 ;
class houseQuestionWidget extends StatefulWidget{
  State<StatefulWidget> createState(){
    return houseQuestionWidgetstate();
  }
}
// create question
class houseQuestionWidgetstate extends State<houseQuestionWidget> {
   var url;
  late PageController controller;
  var Data;
  int questionnum=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=PageController(initialPage: 0);
  }
  @ override
  //build question and question numbering
  Widget build(BuildContext context){

    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30,),
          Text('Question $questionnum / ${housequestions.length} ',
            style: GoogleFonts.getFont('Quando',fontWeight: FontWeight.bold,
                fontSize: 26,color: Colors.cyan.shade900
            ),),
          const Divider(thickness: 1, color: Color(0xFF006064),),
          Expanded(
            child: PageView.builder(
              itemCount: housequestions.length,
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final __question = housequestions[index];
                return buildquestion(__question);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              buildbackFloatingActionButton(),
              SizedBox(width: 10,),
              buildFloatingActionButton(),



            ],
          ),
          const SizedBox(height: 20,),

        ],
      ),
    );

  }
// question still and set option
  Widget buildquestion(Question question) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 32,),
          Text(
            question.text,
            style: GoogleFonts.getFont('Lato',
              fontSize: 25,//fontWeight: FontWeight.bold
            ) ,
          ),
          const SizedBox(height: 32,),
          Expanded(child:  OptionWidget(
              question :question,
              OnClickedOption : (option){

                if(question.isLocked){
                  return;
                }
                else{
                  setState(() {
                    question.isLocked = true;
                    question.selectedOption = option;
                   // question.store![question.index]=option.toString();

                    print(index);
                    print(option.num);
                    store[index]=option.num;
                    index++;
                    print(index);
                  });
                };
                if (questionnum<housequestions.length ){
                  controller.nextPage(duration: const Duration(milliseconds:250 ), curve: Curves.easeInExpo);
                  setState(() {
                    questionnum++;

                  });
                };
              }
          )
          )
        ],
      ),
    );

  }
  FloatingActionButton buildbackFloatingActionButton() {
    return FloatingActionButton(onPressed: () {
      if (questionnum != 0) {
        controller.previousPage(duration: const Duration(milliseconds: 200),
            curve: Curves.easeInExpo);
        setState(() {
          questionnum--;
        });
      }
      else {

      }
    },
      backgroundColor: Colors.cyan.shade800,

      child: Icon(
          Icons.navigate_before

      ),


    );
  }
  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(onPressed: () async {
if(questionnum<housequestions.length){
  controller.nextPage(duration: const Duration(milliseconds:250 ), curve: Curves.easeInExpo);
  setState(() {
    questionnum++;

  });
}
 else {


   final uri = 'http://192.168.56.1:8000/RandomForestmodel';
   final response = await http.post(Uri.parse(uri) ,body:json.encode({
     'carType':store[0],
     'carEfficiency':store[1],
     'car_TraveledDistance':store[2],
     'shortFlightsNumber':store[3],
     'longFlightsNumber':store[4],
     'redMeatServings':store[8],
     'whiteMeatServings':store[9],
     'dairyServings':store[10],
     'livingSpaceArea':store[17],
     'catNumber':store[11],
     'dogNumber':store[12],
     'bus_TraveledDistance':store[5],
     'metro_TraveledDistance':store[6],
     'rail_TraveledDistance':store[7],
     'furnitureAndAppliances_Spendings':store[13],
     'clothes_Spendings':store[14],
     'otherStuff_Spendings':store[15],
     'services_Spendings':store[16],
     'electricityConsumption':store[18],
     'naturalGasConsumption':store[19]
   }));
   http.Response response2 = await http.get(Uri.parse(uri)) as http.Response;
   var decoded=json.decode(response2.body);

setState(() {
  CFValue = double.parse(decoded['value']);
});
  _db.SaveCF(CarbonFootprint(
      userID: UserData.userID,
      value: CFValue,
      startDate: DateTime.now().toString(),
      carType: store[0],
      carEfficiency: store[1],
      car_TraveledDistance: store[2],
      shortFlightsNumber: store[3],
      longFlightsNumber: store[4],
      redMeatServings: store[8],
      whiteMeatServings: store[9],
      dairyServings: store[10],
      livingSpaceArea: store[17],
      catNumber: store[11],
      dogNumber: store[12],
      bus_TraveledDistance: store[5],
      metro_TraveledDistance: store[6],
      rail_TraveledDistance: store[7],
      furnitureAndAppliances_Spendings: store[13],
      clothes_Spendings: store[14],
      otherStuff_Spendings: store[15],
      services_Spendings: store[16],
      electricityConsumption: store[18],
      naturalGasConsumption: store[19])).then((value){
    _db.updateUserCF(UserData.userID!,value!);
  });


  Navigator.push(context, MaterialPageRoute(builder: (context)=>Result()));
}
    },
      tooltip:questionnum<housequestions.length ? 'Go To Next Page' : 'Calculate the carbon footprint' ,
      child: Icon(
          questionnum<housequestions.length ? Icons.navigate_next : Icons.calculate
      ),
      backgroundColor: Colors.cyan.shade800,
      autofocus: true,
    );
  }

}
const List<double> petno=<double>[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
class petQuestionWidget extends StatefulWidget{
  State<StatefulWidget> createState(){
    return petQuestionWidgetstate();
  }
}
class petQuestionWidgetstate extends State<petQuestionWidget> {
  late Question quest;

  double ddropvalue=petno.first;
  double ddropvaluedog=petno.first;
  Widget build(BuildContext context){

    return

      Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,

          children: <Widget>[
            const SizedBox(height: 30,),
            Text('Question 1 / 1 ',
              style: GoogleFonts.getFont('Quando',fontWeight: FontWeight.bold,
                  fontSize: 26,color: Colors.cyan.shade900
              ),),
            const Divider(thickness: 1, color: Color(0xFF006064),),
            const SizedBox(height: 22,),
            Row(

              children: [
                //SizedBox( width: 22,),
                Text(
                  'Enter number of pets you have',
                  style: GoogleFonts.getFont('Lato',
                    fontSize: 25,//fontWeight: FontWeight.bold
                  ) ,

                ),
              ],
            ),
           const SizedBox(height: 12,),

                Row(
                  children: [
                    Text(" Cats : ",
                      style: GoogleFonts.getFont('Lato',
                        fontSize: 23,
                      ) ,),
                    SizedBox(width: 46,),
                     DropdownButton(
                        value: ddropvalue,
                        icon: Icon(Icons.arrow_drop_down_sharp, color:Colors.cyan.shade800),
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          width: 10,
                          color: Colors.cyan.shade800,
                        ),
                        onChanged: (double? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            ddropvalue = value!;
                            print(index);
                            print(ddropvalue);
                            store[index]= ddropvalue  ;
                            index++;
                            print(index);
                          });
                        },
                        items: petno.map<DropdownMenuItem<double>>((double value) {
                          return DropdownMenuItem<double>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),

                  ],
                ),




      Row(
           children: [
             Text(" Dogs : ",
               style: GoogleFonts.getFont('Lato',
                 fontSize: 23,
               ),),
              SizedBox(width: 40,),
              DropdownButton(
                 value: ddropvaluedog,
                 icon: Icon(Icons.arrow_drop_down_sharp, color:Colors.cyan.shade800),

                 style: const TextStyle(color: Colors.black),
                 underline: Container(
                   height: 2,
                   width: 10,
                   color: Colors.cyan.shade800,
                 ),
                 onChanged: (double? value) {
                   // This is called when the user selects an item.
                   setState(() {
                     ddropvaluedog = value!;
                     print(index);
                     print(ddropvaluedog);
                     store[index]= ddropvaluedog  ;
                     index++;
                     print(index);
                   });
                 },
                 items: petno.map<DropdownMenuItem<double>>((double value) {
                   return DropdownMenuItem<double>(
                     value: value,
                     child: Text(value.toString()),
                   );
                 }).toList(),
               ),

           ],
         ),



          ],

      ),
       );


  }
}

