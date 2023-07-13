import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project_app/CarbonFootprint.dart';
import 'package:intl/intl.dart';


import '../User.dart';
import '../userHabit.dart';



class Database {
  CollectionReference UserRef = FirebaseFirestore.instance.collection("User");
  CollectionReference CFRef = FirebaseFirestore.instance.collection(
      "CarbonFootprint");
  CollectionReference HabitRef = FirebaseFirestore.instance.collection("Habit");
  CollectionReference UserHabitRef = FirebaseFirestore.instance.collection(
      "UserHabit");

  SaveAccount(Account user) async {
    await UserRef.doc(user.userID).set(user.toMap());
  }

  SaveUserHabit(userHabit uHabit) async {
    await UserHabitRef.doc().set(uHabit.toMap());
  }

  Future<String> getUsername(String userID) async {
    String? uname;
    await UserRef.doc(userID).get().then((value) {
      uname = value.get('username');
    }).catchError((error) {
      print(error.toString());
    });
    return (uname!);
  }


  Future<List<double>> getCFofUser(String uID) async {
    String? ucf;
    List<double> list = List.filled(13, 0.0);
    await UserRef.doc(uID).get().then((value) {
      ucf = value.get('carbonFootprint');
    });
    await CFRef.doc(ucf).get().then((value) {
      list[0] = value.get('redMeatServings');
      list[1] = value.get('naturalGasConsumption');
      list[2] = value.get('car_TraveledDistance');
      list[3] = value.get('shortFlightsNumber');
      list[4] = value.get('longFlightsNumber');
      list[5] = value.get('whiteMeatServings');
      list[6] = value.get('livingSpaceArea');
      list[7] = value.get('dairyServings');
      list[8] = value.get('furnitureAndAppliances_Spendings');
      list[9] = value.get('bus_TraveledDistance');
      list[10] = value.get('value');
      list[11] = value.get('clothes_Spendings');
      list[12] = value.get('electricityConsumption');
    });
    return list;
  }

  Future<String> SaveCF(CarbonFootprint cf) async {
    String? id;
    await CFRef.get().then((value) {
      if (value.size == 0) {
        id = 0.toString();
      }
      else {
        id = value.size.toString();
      }
    });
    await CFRef.doc(id).set(cf.toMap());
    return (id!);
  }

  updateUserCF(String userID, String value) {
    UserRef.doc(userID).update({
      'carbonFootprint': value,
    });
  }
  updateUserHabitStatus(String uID, String hID)async{
    await UserHabitRef.where('userID', isEqualTo: uID)
        .where('habitID', isEqualTo: hID)
        .get()
        .then((value){
      UserHabitRef.doc(value.docs[0].id).update({
        'isCompleted':true,
      });
    });
  }
  updateDaysList(String uID, String hID, List<bool> val)async{
    await UserHabitRef.where('userID', isEqualTo: uID)
        .where('habitID', isEqualTo: hID)
        .get()
        .then((value){
      UserHabitRef.doc(value.docs[0].id).update({
        'daysList':val,
      });
    });
  }
  updateCFEndDate(String uID) async {
    await CFRef.get().then((value) {
      if (value.size != 0) {
        CFRef.where('userID', isEqualTo: uID)
            .where('endDate', isEqualTo: "")
            .get()
            .then((value) {
          print("length:");
          print(value.docs.length);
          for (int i = 0; i < value.docs.length; i++) {
            CFRef.doc(value.docs[i].id).update({
              'endDate': DateTime.now().toString()
            });
            print(value.docs[i].id + '  updated');
          }
          print("updated");
        });
      }
    }).catchError((error) {
      print(error.toString());
    });
  }


  Future getHabits(String uID) async {
    //return await PostsRef.snapshots();
    return await UserHabitRef.where('userID', isEqualTo: uID)
        .snapshots();
  }

  Future getAllHabits() async {
    return await HabitRef.get();
  }

  Future<String> getHabitTitle(String hID) async {
    String? title;
    await HabitRef.doc(hID).get().then((value){
      title = value.get('habitTitle').toString();
    });
    return title!;
  }
  deleteUserHabit(String uID, String hID)async{

    await UserHabitRef.where('userID', isEqualTo: uID)
        .where('habitID', isEqualTo: hID)
        .get()
        .then((value) {
      print(value.docs.length);

      String id = value.docs[0].id;
      UserHabitRef.doc(id).delete().then((value) {

       print("Document deleted");
      });
    });
  }
  Future<List<bool>> getDaysList(String uID, String hID)async{
    List<bool> list=[];
    await UserHabitRef.where('userID', isEqualTo: uID)
        .where('habitID', isEqualTo: hID)
        .get()
        .then((value) async{

      String id = value.docs[0].id;
      await UserHabitRef.doc(id).get().then((value) {
         int? len;
         len = value.get('daysList').length;
        for(int i = 0; i < len!;i++){
          list.add(value.get('daysList')[i]);
        }

      });
    });
    return list;
  }

}