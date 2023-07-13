import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_app/CurrentUserData.dart';
import 'package:graduation_project_app/userHabit.dart';
import 'package:graduation_project_app/Services/FileStore.dart';
import 'habits.dart';


import 'HabitsPage.dart';
import 'habits.dart';

List<habits>selected=[];

class MyHabitPage extends StatefulWidget {
  MyHabitPage({Key? key}) : super(key: key);


  @override
  _MyHabitPageState createState() => _MyHabitPageState();
}

class _MyHabitPageState extends State<MyHabitPage> {
  List<habits> habit=[];

  Database db = new Database();

  void dispose(){
    //selected.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();

    db.getAllHabits().then((snapshots){
      for(int i = 0; i < snapshots.docs.length; i++){
        String title = snapshots.docs[i].get('habitTitle');
        String id = snapshots.docs[i].id;
        setState(() {
          if(selected.any((element) => element.name == title)) {
            habit.add(habits(title, true, int.parse(id)));
          }
          else{
            habit.add(habits(title, false, int.parse(id)));
          }
        });

      }
    });


  }
  /*List<habits> habit=[
    habits("Use Your Cars in efficient way",false,0),
    habits("Eat more vegetables", false,1),
    habits("Save Your Money", false,2),
    habits("Managing Your Furniture needs", false,3),
    habits("Minimizing the use of supplies", false,4),
    habits("Reducing the frequency of clothing purchases ", false,5),
    habits("Minimizing the use of services", false,6),
    habits("Using energy-efficient appliances and electronics", false,7),
    habits("Reducing natural gas consumption", false,8),
    habits("Using less dairy products", false,9),
    habits("Use bike for traveling", false,10),
    habits("Reducing the frequency of inter city rail", false,11),
    habits("Minimizing the number of long-flights", false,12),
    habits("Minimizing the number of short-flights", false,13),
    habits("Opting to travel by bus", false,14),
    habits("Share your house", false,15),
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: //Color(0xff131b26)
        Colors.white ,
        appBar: AppBar(
          title: Text("Log a new habit",style:GoogleFonts.getFont('Quando', fontSize: 20)),
          backgroundColor: Colors.cyan.shade800,
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [

                Expanded(
                  child: ListView.builder(itemCount: habit.length,
                      itemExtent: 65,itemBuilder: (BuildContext context,int index){
                    return habititem(habit[index].name, habit[index].isselected,"", index,);
                  }),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10,),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.cyan.shade800,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          if(selected.length >=1) {
                            setState(() {
                              for(int i =0; i < selected.length; i++){
                                print(selected.length);
                                print(startDateMap.length);
                                print(selected[i].index);
                                print(startDateMap['1']);
                                print(startDateMap.containsKey(selected[i].index.toString())==false);
                                if(startDateMap.containsKey(selected[i].index.toString())==false) {
                                  startDateMap[selected[i].index]=DateTime.now();
                                  print("start date   "+startDateMap[selected[i].index].toString()+"added for:  "+selected[i].index.toString());
                                }
                              }
                            });
                            Navigator.of(context).push(MaterialPageRoute(builder: (
                                context) => seletscreen(),
                            ));
                          }
                        },
                        child:Text("Done ",style:GoogleFonts.getFont('Quando', fontSize: 20),)
                    ),
                  ),),
              ],
            ),
          ),
        )
    );
  }
  List<int>ind=[];
  Widget habititem(String name,bool isselected,String description,int index){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 20,
      shadowColor: Colors.black26,
      child: ListTile(
        title:Text(
          name,
          style: GoogleFonts.getFont('Lato',fontSize:18,fontWeight: FontWeight.w900),
        ) ,
        trailing: isselected ?Icon(Icons.check_circle,color: Colors.cyan.shade700,): Icon(Icons.check_circle_outline,
          color:Colors.black ,),
        onTap: (){
          setState(() {
            habit[index].isselected=!habit[index].isselected;
            if(habit[index].isselected==true){
              if(!selected.any((element) => element.name == habit[index].name)){
                selected.add(habits(name,true,index));
                print("yeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeesss");
                print("leeeeeeeeeeeeeeeen"+selected.length.toString());
                db.SaveUserHabit(userHabit(userID:UserData.userID!,habitID: index.toString()));
                startDateMap[index.toString()] = DateTime.now();
              }


            }else if(habit[index].isselected==false){
              selected.removeWhere((element) => element.name == habit[index].name);
              db.deleteUserHabit(UserData.userID!, index.toString());
            }

          });
        },
      ),
    );
  }
}