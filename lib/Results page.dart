import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_app/News_screen.dart';
import 'Calculator.dart';
import 'HomeScreen.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project_app/Navigation%20bar.dart';


class Result extends StatefulWidget {
  _Resultwid createState() => _Resultwid();

}
class _Resultwid extends State<Result> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        bottomNavigationBar: buildMyNavBar(context),backgroundColor: Color(0xFFf9f2ec),

        appBar: AppBar(
          backgroundColor:Colors.cyan.shade800,

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

          ]*/
          title: Text('Your Carbon Footprint',style:GoogleFonts.getFont('Quando', fontSize: 20)),
        ),
        body:
        Column(
          children: [
            Container(
              color:Color(0xFFf9f2ec),
              child: Column(
                  children: [
                    Container(height: 20,),
                    /*()Text(
                      'Your Carbon Footprint',
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),*/
                    Container(height: 10,),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.cyan.shade800,
                        radius: 90,
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFf9f2ec),
                          radius: 80,
                          child: CircleAvatar(
                            backgroundColor: Colors.cyan.shade800,
                            radius: 70,
                            child: Text(
                              "      "+(CFValue)!.toStringAsFixed(2)+'\nTons of CO2',
                              style: GoogleFonts.getFont('Lato',
                                fontSize: 20,color: Colors.white//fontWeight: FontWeight.bold
                              ) ,
                            ),
                          ), //CircleAvatar
                        ), //CircleAvatar
                      ),
                    ),

                  ]//CircleAvatar
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: SfCartesianChart(
                // title: ChartTitle(text: 'carbon footprint '),
                legend: Legend(isVisible: false),
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries>[
                  BarSeries<GDPData, String>(
                      dataSource: _chartData,
                      xValueMapper: (GDPData gdp, _) => gdp.continent,
                      yValueMapper: (GDPData gdp, _) => gdp.gdp,
                      width: 0.2,
                      spacing: 0.1,
                      pointColorMapper: (GDPData gdp, _) => gdp.color,

                      borderRadius: BorderRadius.all(Radius.circular(19)) ,
                      dataLabelSettings: DataLabelSettings(isVisible: true),

                      enableTooltip: true),

                ],

                primaryXAxis: CategoryAxis() ,
              ),

              height:280.0,
            ),
          ],
        ), //Center
      ),
    );
  }
  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('World', 6.6,Colors.cyan.shade800),
      GDPData('Egypt', 3.5,Colors.cyanAccent),
      GDPData('You', double.parse((CFValue)!.toStringAsFixed(2)),Colors.yellow.shade700),

    ];
    return chartData;
  }
}//Scaffold
//MaterialApp

class GDPData {
  GDPData(this.continent, this.gdp,this.color);
  final String continent;
  final double gdp;
  final Color color;
}