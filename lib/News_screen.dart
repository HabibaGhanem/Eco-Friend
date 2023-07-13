import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';

import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;

import 'Navigation bar.dart';
import 'News.dart';
import 'package:graduation_project_app/Calculator.dart';
import 'HomeScreen.dart';



class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String url ='http://192.168.56.1:5000/News';
  //String url ='http://127.0.0.1:5000/';
  var response;
  int toggleValue = 0;
  List<News> news =[];
  Future<List<News>>fetchEgydata(String url) async{

    http.Response response = await http.get(Uri.parse(url)) as http.Response;
    var responseData = json.decode(response.body);
    //print(responseData);

    for(var response in responseData[1]){
      News n = News(title: response["title"],
          description:response["description"], link: response["link"]);
      news.add(n);
      //print(n.title);
      //print(n.description);
    }
    return news;
  }
  Future<List<News>>fetchWWdata(String url) async{

    http.Response response = await http.get(Uri.parse(url)) as http.Response;
    var responseData = json.decode(response.body);
    //print(responseData);
    List<News> news =[];
    for(var response in responseData[0]){
      News n = News(title: response["title"],
          description:response["description"], link: response["link"]);
      news.add(n);
      //print(n.title);
      //print(n.description);
    }
    return news;
  }

   @override
    void initState() {
      response = fetchEgydata(url);
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    double scwidth = MediaQuery.of(context).size.width;
    double scheight = MediaQuery.of(context).size.height;
    int value = 0;


    return Scaffold(
        bottomNavigationBar: buildMyNavBar(context),backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('Latest Climate News',
          style: GoogleFonts.getFont('Quando',//fontWeight: FontWeight.bold,
              fontSize: 20,//color: Colors.cyan.shade900
          ),),
        backgroundColor: Colors.cyan.shade800,
      ),
body:SingleChildScrollView(
  child:
    Container(
      margin: EdgeInsets.all(10),
alignment: AlignmentDirectional.center,
      child: Column(
        children: [
          Container(
            child: ToggleSwitch(
              minWidth: scwidth,
              minHeight: scheight*0.08,
              activeBgColor: [Colors.cyan.shade800],
              inactiveBgColor: Colors.black12,
              initialLabelIndex: toggleValue,
              totalSwitches: 2,
              customTextStyles: [toggleValue==0?GoogleFonts.getFont('Quando', fontSize: 15,color: Colors.white)
                  :GoogleFonts.getFont('Quando', fontSize: 15,color: Colors.black),
  toggleValue==1?GoogleFonts.getFont('Quando', fontSize: 15,color: Colors.white)
      :GoogleFonts.getFont('Quando', fontSize: 15,color: Colors.black)],
              labels: ['Egypt', 'Worldwide'],
              onToggle: (v) {
                setState(() {
                  toggleValue=v!;
                  if(v == 0){
                     response = fetchEgydata(url);
                  }
                  else {
                    response = fetchWWdata(url);
                  }
                });

              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:10),
            height: scheight*0.7,
            child: myAppWidget(response)

          ),
        ],
      ),
    )

)
    );
  }

}

myAppWidget(var response){
  return FutureBuilder(
    future: response,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasError) {
        return Text('Error!');
      } else if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 20,
              shadowColor: Colors.black26,
              child: Column(
                children: [
                  ListTile(
                    title: GestureDetector(onTap:()async{
                      Uri _url = Uri.parse(snapshot.data[index].link);
                      if (!await launchUrl(_url)) {
                        throw Exception('Could not launch $_url');
                      }
                      },
              child: Text(snapshot.data[index].title,style: GoogleFonts.getFont('Lato',fontWeight: FontWeight.w900
              ) ,)),
                    subtitle: Text(snapshot.data[index].description,style: GoogleFonts.getFont('Lato')),
                  )
                ],
              ),
            );
          },
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}
