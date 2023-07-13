import 'package:flutter/material.dart';
class information_page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return  SafeArea(child: Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child:  Image.network('https://previews.123rf.com/images/vencavolrab78'
                '/vencavolrab782110/vencavolrab78211000046'
                '/175409487-open-book-with-live-and-dead-tree-global-warming-or-climate-change-concepts.jpg'),

          ),
          scroll()
        ],
      ),
    )
    );
  }
  scroll(){
    return DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 1.0,
        minChildSize: 0.7,
        builder: (context,scrollControllar){
         return Container(
           padding: EdgeInsets.symmetric(horizontal: 20),
           clipBehavior: Clip.hardEdge,
           decoration: BoxDecoration( color: Colors.green,
               borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
               topRight: Radius.circular(20))
           ),
           child: SingleChildScrollView(
             controller: scrollControllar,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(padding: const EdgeInsets.only(top: 10,bottom: 25),
               child: Row(mainAxisAlignment: MainAxisAlignment.center,
                 children: [Container(
                   height: 5,
                   width: 35,
                   color: Colors.black12,
                   
                 )],)
               ),
               Text("Global warming and fossil fuels",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
               const SizedBox(height: 10,),
               Text("About three-quarters of greenhouse gas emissions that are attributed to humans come from burning fossil fuels. We burn fossil fuels — non-renewable energy sources — when we operate vehicles,"
                   " heat our homes, and even use electricity",style: TextStyle(color: Colors.white),),
               const SizedBox(height: 20,),
               Text("Climate change and recycling",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
               const SizedBox(height: 10,),
               Text("Although reducing energy use is today’s latest rage,"
                   " a measure of your carbon footprint will also include recycling. According to Carbon Footprint, "
                   "a carbon management business, when you don’t recycle,"
                   " you waste the energy that is used making and transporting new items."
                   " Recycling and reusing allows less energy to go into the process of creating new items."
                   " This means fewer fossil fuels are being used. In addition, Carbon Footprint points out that when you recycle, "
                   "your garbage takes up less room in landfills. Thus, by not recycling, you increase your greenhouse gas emissions,"
                   " contributing to climate change.",style: TextStyle(color: Colors.white),),

               const SizedBox(height: 20,),
               Text("Reducing your carbon footprint",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
               const SizedBox(height: 10,),
               Text("There are several ways to combat climate change by reducing your carbon footprint. First, you can recycle, use less electricity and use public transportation. In addition to these lifestyle changes, many companies now allow you to buy credits that neutralize your carbon usage. In fact, this movement has been popular with some commercial companies. A carbon credit is a dollar amount that will go toward offsetting emissions. Individuals and companies buy the credits through environmental improvement agencies, who dedicate them to carbon-offsetting projects. Many companies sell carbon credits online, but it is important"
                   " to ensure you buy credits from reputable organizations in order to ensure that you are reducing your carbon"
                   " footprint",style: TextStyle(color: Colors.white),),

             ],
           ),
           )
         );
        }
        );
  }
  }
