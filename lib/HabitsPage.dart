import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_app/CurrentUserData.dart';
import 'package:graduation_project_app/HabitsMainPage.dart';
import 'package:graduation_project_app/Services/FileStore.dart';
import 'HomeScreen.dart';
import 'Navigation bar.dart';
import 'achievementPage.dart';
import 'getDescriptions.dart';
import 'habits.dart';
import 'package:intl/intl.dart';

var startDateMap = new Map();

class seletscreen extends StatefulWidget {
  //final List<habits> habit;
  //seletscreen(this.habit);
@override
_seletscreenState createState() => _seletscreenState();
}

class _seletscreenState extends State<seletscreen> {

  var DaysList = new Map();
  var datesMap = new Map();

  Database db = new Database();
  getDaysInBetween(DateTime startDate, DateTime endDate,String hID){
    setState((){
    List<DateTime> dates =[];
    for(int i = 0; i < endDate.difference(startDate).inDays;i++){
        dates.add(startDate.add(Duration(days:i)));
    }
    datesMap[hID]=dates;
    });

  }
  get(String s){
    var list = <bool>[];
    db.getDaysList(UserData.userID!, s).then((value){
      //print(s+" => habit index");
      //print(value.length.toString()+" => value.length");
      setState(() {
        //print("valuuuuuuuuuuuuuueee"+value.length.toString());
        for(int i = 0; i < value.length;i++){
          //print(i.toString()+" => [i]");
          //print(value[i].toString()+" => value[i]");
          list.add(value[i]);
        }
        DaysList[s]=list;
        //print("daaaaaaaaaaaysss"+DaysList[s].length.toString());

        //print("heeeeeeeeeeeeeeeeereeeeeeeeeeeeeeeee");
      });

    });

  }
  seq()async{

    //print(widget.habit.length);
    print("helooooooooooooooo");
    for(int i =0; i < selected.length; i++){
      DateTime sDate = startDateMap[selected[i].index.toString()];
      //print(sDate.toString());
      DateTime endDate = sDate.add(const Duration(days:21));
      //print(endDate.toString());
      //print(widget.habit[i].index.toString());
      print("==================================");
      await getDaysInBetween(sDate, endDate,selected[i].index.toString());
      await get(selected[i].index.toString());

    }
  }
  //late Stream HabitsStream;

  /*getHabits() {
    db.getHabits(UserData.userID!).then((snapshots) {
      setState(() {
        HabitsStream = snapshots;
      });
    });
  }*/
  @override
  void initState() {
    super.initState();
    //getHabits();
    seq();




  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: buildMyNavBar(context),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(top: 25.0, left: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      softWrap: true,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Your Habits",
                              style:GoogleFonts.getFont('Quando', fontSize: 25,color: Colors.black)
                          ),

                        ],
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                          padding: EdgeInsets.all(9.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.cyan.shade800,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.cyan.shade700,
                                  offset: Offset(0, 3),
                                  blurRadius: 5.0),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (
                                  context) => MyHabitPage(),
                              ));
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  )
                ],
              ),
              Text(
                  DateFormat('E, d MMM').format(DateTime.now()),
                  style:GoogleFonts.getFont('Lato', fontSize: 17,color: Colors.black45)
              ),
              SizedBox(
                height: 35.0,
              ),

              // ListItem(id: 1,)
              Expanded(
                child: ListView.separated(
                  itemCount: selected.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20.0);
                  },
                  itemBuilder: (ctx, index) {
                    habits h = selected[index];
                    //print("habit index=>  "+ h.index.toString());
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[

                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    h.name,
                                style: GoogleFonts.getFont('Lato',fontWeight: FontWeight.w900,
                                fontSize: 20,color: Colors.black),
                                  ),
                                  //SizedBox(height: 15),
                                ],
                              ),
                            ),
                            //SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.only(right: 14.0,left: 10),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.info,
                                  color: Colors.cyan.shade800,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => des_of_habits(h)),
                                  );
                                },
                              ),
                            ),
                            /*Padding(
                              padding: const EdgeInsets.only(right:12.0),
                              child: Container(
                                //padding: EdgeInsets.all(5.0),
                                width:25,
                                height:25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.cyan.shade800,
                                  border: Border.all(color: Colors.cyan.shade800),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => des_of_habits(h)),
                                    );
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.info,
                                      color: Colors.cyan.shade800,
                                    ),
                                  ),
                                ),
                              ),
                            ),*/

                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: DaysList.containsKey(h.index.toString()) && DaysList[h.index.toString()].length==21?<Widget>[
                              for (int i = 0; i < datesMap[h.index.toString()].length; i++)
                                InkWell(
                                  child: Container(
                                    width:55 ,
                                    height:50,
                                    padding: EdgeInsets.all(8.0),
                                    margin:EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      //border: Border.all(color: Colors.white),
                                      shape: BoxShape.circle,
                                      color: DateFormat('yyy-MM-dd').format(datesMap[h.index.toString()][i])
                                          ==DateFormat('yyy-MM-dd').format(DateTime.now()) ?
                                      Colors.cyan.shade800 : Colors.grey,
                                    ),
                                    child: ((){
                                      //print("22222222222222222222222222222222222222");
                                      //print("index ====> "+i.toString());

                                      if(datesMap[h.index.toString()][i].isAfter(DateTime.now()) ||
                                          DateFormat('yyy-MM-dd').format(datesMap[h.index.toString()][i])
                                          ==DateFormat('yyy-MM-dd').format(DateTime.now())){
                                        //print("greater than");
                                        if(DaysList[h.index.toString()][i]){
                                          return Icon(Icons.check,color: Colors.white,);
                                        }
                                      else {
                                          return Center(
                                            child: Text(
                                              DateFormat('E').format(
                                                  datesMap[h.index
                                                      .toString()][i]),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                          );
                                        }
                                    }else{
                                        if(DaysList[h.index.toString()][i]){
                                          //print(DaysList[h.index.toString()][i].toString());
                                          //print("check");
                                          return Icon(Icons.check,color: Colors.white,);
                                        }else{

                                          //print("close");
                                          return Icon(Icons.close,color: Colors.white,);

                                        }
                                    }}())



                                  ),
                                  onTap: (){
                                    if(DateFormat('yyy-MM-dd').format(datesMap[h.index.toString()][i])
                                        ==DateFormat('yyy-MM-dd').format(DateTime.now())){

                                      setState(() {
                                        DaysList[h.index.toString()][i] = !DaysList[h.index.toString()][i];
                                        db.updateDaysList(UserData.userID!,h.index.toString(),DaysList[h.index.toString()]);
                                        if(i==datesMap[h.index.toString()].length-1){
                                          int counter = 0;
                                          for (int i = 0; i < DaysList[h.index.toString()].length; i++) {
                                            if (DaysList[h.index.toString()][i]) {
                                              counter++;
                                            }
                                          }
                                          if (counter == 21) {
                                            setState(() {
                                              db.updateUserHabitStatus(UserData.userID!,h.index.toString());
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => RewardPage(h.name)));
                                            });
                                          }
                                        }
                                      });

                                    }
                                  },
                                ),
                            ]:<Widget>[Center(
                              child: CircularProgressIndicator(),
                            ),],
                          ),
                        ),
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: DateTime.now().weekday == 1 ? Colors.deepPurpleAccent : Colors.grey,
                              ),
                              child: Text(
                                'M',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: DateTime.now().weekday == 2 ? Colors.deepPurpleAccent : Colors.grey,
                              ),
                              child: Text(
                                'T',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: DateTime.now().weekday == 3 ? Colors.deepPurpleAccent : Colors.grey,
                              ),
                              child: Text(
                                'W',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: DateTime.now().weekday == 4 ? Colors.deepPurpleAccent : Colors.grey,
                              ),
                              child: Text(
                                'T',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: DateTime.now().weekday == 5 ? Colors.deepPurpleAccent : Colors.grey,
                              ),
                              child: Text(
                                'F',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: DateTime.now().weekday == 6 ? Colors.deepPurpleAccent : Colors.grey,
                              ),
                              child: Text(
                                'S',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: DateTime.now().weekday == 0 ? Colors.deepPurpleAccent : Colors.grey,
                              ),
                              child: Text(
                                'S',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),*/
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}