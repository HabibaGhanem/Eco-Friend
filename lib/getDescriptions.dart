import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'habits.dart';
class des_of_habits extends StatelessWidget{
  habits h;
  des_of_habits(this.h);
  @override
  Widget build(BuildContext context) {
    List<String>urls=[
      "https://www.shutterstock.com/image-vector/car-sharing-banner-economy-transport-260nw-1351335566.jpg", //0
      "https://www.shutterstock.com/image-photo/assorted-organic-vegetables-fruits-wicker-260nw-1720876849.jpg",//1
      "https://cdn.pixabay.com/photo/2017/09/07/08/54/money-2724241__480.jpg",                               //2
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVINFp6Z88CE1vJRbsMYaetoiEsQVNmsykSw&usqp=CAU",//3
      "https://c4.iggcdn.com/indiegogo-media-prod-cld/image/upload/c_fill,w_695,g_auto,q_auto,dpr_1.3,f_auto,h_460/bnadsewhatdoig61twwt",//4
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzAgKTXKvr4URvwjDOZa_FcCEdiKE-KVB9iw&usqp=CAU",//5
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2epY8OQWuD-FE1YbQjSQX65z7SCKvMeUHBA&usqp=CAU",//6
      "https://cdn.pixabay.com/photo/2014/10/26/14/36/light-bulb-503881__340.jpg",                          //7
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUNxaQuP9bAPQSzsIw_YJzI-67JmcjAYQzMg&usqp=CAU", //8
      "https://th.bing.com/th/id/R.f42ba39a8681770f8cb0aa12f83205da?rik=26NEz%2fAQQQY%2fzQ&pid=ImgRaw&r=0",//9
      "https://th.bing.com/th/id/R.d748997f7b2d39b6b15b8947e159043b?rik=3VhxWh1vxAE%2b2w&pid=ImgRaw&r=0",//10
      "https://i.pinimg.com/originals/dc/d8/87/dcd88752bde0722b74aa6ddf4079f2b3.jpg",                     //11
      "https://travelunpacked.co.uk/wp-content/uploads/2012/12/Easyjet.jpg",                             //12
      "https://travelunpacked.co.uk/wp-content/uploads/2012/12/Easyjet.jpg",                            //13
      "https://img.51miz.com/Element/00/36/48/88/b5ef0d89_E364888_cc2c3ff2.png",                        //14
      "https://th.bing.com/th/id/OIP.P8cLtOIA_IlZ7FxffBaZRQHaHA?pid=ImgDet&rs=1"                        //15
    ];

    List<String>des = [
    "Reading, studying, working or doing household chores in the sunlight has a different energy! Turn off unnecessary lights and enjoy some natural light, draw the curtains, open the windows and enjoy the warmth of the sun. A simple action that improves your mood, productivity, is good for your health and helps you reduce energy costs!", //0
      "One million plastic bottles are sold worldwide every minute, most of them made of polyethylene terephthalate (PET),"
          " produced from crude oil. They are a huge part of the amount of pollution that ends up in our landfills and oceans. Maybe "
          "it's better to use a refillable bottle? We totally agree with you! Take your bottle wherever you go, "
          "fill it up at public fountains.",//1
      "Chatting with friends or colleagues, you discover that every morning you and three other people take the same "
          "journey at the same time, but each with their own car. Get organized and share the car: you will halve emissions and fuel costs.",//2
      "Aaah a well-deserved rest... very important for you and, for your appliances! If you unplug electronic devices "
          "when you don't actually need them, you'll save energy and money, while doing a lot of good for the environment. Computers, "
          "printers, TVs and devices consume energy even when they're off: send everyone on vacation, unplug them when you're not using"
          " them!",//3
    "Make the choice today to travel by public transport instead of using a car!  Cities are crowded with cars that create traffic, produce high CO2 emissions that cause a deterioration in the quality of the air we breathe. Think of how much space would be freed up and how many fewer emissions there would be if we took 50 cars off the road and put those drivers on a bus!",//4
      "Do you have to make a short journey and want to forget the stress of finding parking, perhaps during rush hour"
          " or in a crowded area? Walk instead "
          "of taking the car: a nice walk reduces stress, is good for health and allows you to discover unexplored corners of the city!",//5
      "Make the choice today to travel by public transport instead of taking a taxi! Cities are crowded with cars - private and otherwise - which create traffic, produce high CO2 emissions which cause a deterioration in the quality of the air we breathe. Think of how much space would be freed up and how many fewer emissions there would be if we took 50 cars off the road and put drivers on a train!",//6
      "Did you know that eating less meat and dairy and more plant-based foods- such as vegetables, "
          "fruits, whole grains, legumes, nuts and seeds-can significantly reduce your environmental footprint?"
          " Plant-based foods produce fewer greenhouse gas emissions and use less energy, land and water. Vegan "
          "doesn't mean sad and tasteless, quite the contrary! Today on the internet you can find thousands of tasty and "
          "low-impact recipes.",//7
      "Did you know that eating less meat and dairy and more plant-based foods- such as vegetables, fruits,"
          " whole grains, legumes, nuts and seeds-can significantly reduce your environmental footprint? Plant-based "
          "foods produce fewer greenhouse gas emissions and use less energy, land and water. Vegan "
          "doesn't mean sad and tasteless, quite the contrary! Today on the internet you can find thousands of "
          "tasty and low-impact recipes.",//8
      "Did you know that eating less meat and dairy and more plant-based foods- such as vegetables,"
          " fruits, whole grains, legumes, nuts and seeds-can significantly reduce your environmental footprint?"
          " Plant-based foods produce fewer greenhouse gas emissions and use less energy, land and water. Vegan "
          "doesn't mean sad and tasteless, quite the contrary! Today on the internet you can find thousands of tasty"
          " and low-impact recipes.",//9

    ];
    return  Scaffold(
      appBar: AppBar(title: Text(h.name,style:GoogleFonts.getFont('Lato', fontSize: 18),),
        backgroundColor: Colors.cyan.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(urls[h.index]),
            Padding(padding: const EdgeInsets.all(5.0),
              child: Text(
                des[h.index],
                textAlign: TextAlign.center,
                style:GoogleFonts.getFont('Lato', fontSize: 20,fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w800),
              ),),

          ],
        ),
      ) ,
    );
  }

}
//signup
//forgot
//login
//home
//profile
// calc   car, clothes
//habit
//desc
//add habit 0
//news
//info