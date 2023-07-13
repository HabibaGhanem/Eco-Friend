import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CurrentUserData.dart';
import 'Services/FileStore.dart';
import 'Calculator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project_app/Navigation%20bar.dart';


import 'HomeScreen.dart';
import 'Results page.dart';

class ProfilePage1 extends StatefulWidget {
  const ProfilePage1({Key? key}) : super(key: key);

  @override
  _ProfilePage1State createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfilePage1> {

  Database _db = new Database();
  var CFs = <double>[];
  var Dates = <String>[];

  late List<carbonseries> _linechartData;
  late TooltipBehavior _tooltipBehavior;


  getUserAllCF(String uID)async{
    DateTime? date;
    String? dateInStr;
    await _db.CFRef.get().then((value){
      _db.CFRef.where('userID',isEqualTo: uID).get().then((value){
        for(int i=0;i<value.docs.length;i++)
        {
          date = DateTime.parse(value.docs[i].get('startDate'));
          dateInStr = DateFormat('MMM d, yyyy').format(date!);
          setState(() {
            CFs.add(value.docs[i].get('value'));
            Dates.add(dateInStr!);
            print(CFs[i]);
            print(Dates[i]);
          });

        }
          _linechartData = getlineChartData();


      });
    });

  }
  @override
  void initState(){
     getUserAllCF(UserData.userID!);
     _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildMyNavBar(context),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Expanded(flex: 1, child: _TopPortion()),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  username!,
                    style:GoogleFonts.getFont('Lato', fontSize: 28)
                ),
                const SizedBox(height: 20),


                const SizedBox(height: 20),
                Container(
                  height:180.0,
                  child: CFs.isNotEmpty?SfCartesianChart(
                    // title: ChartTitle(text: 'carbon footprint '),
                    legend: Legend(isVisible: false),
                    tooltipBehavior: _tooltipBehavior,
                    series: <ChartSeries>[
                      LineSeries<carbonseries, String>(
                        dataSource: _linechartData,
                        xValueMapper: (carbonseries cs, _) => cs.date,
                        yValueMapper: (carbonseries cs, _) => cs.cf,
                        width: 3,
                        color: Colors.cyan.shade800,),

                    ],

                    primaryXAxis: CategoryAxis() ,
                  ):Center(child: CircularProgressIndicator()),
                ),
                const SizedBox(height: 25),
                Text('Your Carbon Footprint\n\n'+"     "+
                    cf!.toStringAsFixed(2)!+' Tons of CO2',
                    style:GoogleFonts.getFont('Lato', fontSize: 25)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  List<carbonseries> getlineChartData() {
    var linechartData = <carbonseries>[];
      /*carbonseries("16-3-2023", carbonfootprint),
      carbonseries("16-4-2023", 10 ),
      carbonseries("16-5-2023", 0),
      carbonseries("16-6-2023", 7),*/
      for(int i = 0; i < CFs.length;i++){
        linechartData.add(carbonseries(Dates[i], CFs[i]));
      }
    return linechartData;
  }
}






class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 110),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFB2EBF2), Color(0xFF00BCD4)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/themes/2675221/settings_images/ybI2rCnQf70xdYfxVN4Q_Person_icon.png')),
                  ),
                ),
                ],
            ),
          ),
        )
      ],
    );
  }
}
class carbonseries{
  carbonseries(this.date,this.cf);
    final String date;
    final double cf;

}