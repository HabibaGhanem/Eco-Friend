import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Calculator.dart';
class RewardPage extends StatefulWidget {
  final String rewardName;

  RewardPage(this.rewardName);

  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.calculate_outlined),
              onPressed: () { Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyApp()));
              },
            );
          },
        )],
        title: Text('Reward',style: GoogleFonts.getFont('Quando',
          fontSize: 23,
        ),),
        backgroundColor: Colors.cyan.shade800,
      ),
      body: Container(
        color: Colors.blueGrey[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                SizedBox(width: 10,height: 10,),
                Text(
                  'Congratulations!',

                      style: GoogleFonts.getFont('Quando',
                        fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black
                      )

                ),
              ],
            ),
            SizedBox(height: 30),

            ClipOval(
              child: Image.asset(
                'assets/22190f285b75e685474a055f99aa13b6_1.jpg',
                width: 250,
                height: 250,
                alignment: AlignmentDirectional.topCenter,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'You have completed a task of ${widget.rewardName} for 21 days in a row',
              style: GoogleFonts.getFont(
                'Lato',
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}