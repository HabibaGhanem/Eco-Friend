import 'package:flutter/cupertino.dart';


class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;
   List<String>? store; //20 value(answer)
   int index;

  Question({
    required this.text,
    required this.options,

    this.isLocked = false,
    this.selectedOption,
    this.store,
    this.index=0

  });
}
class Option {
  final String text;
  final double num;
  const Option({
    required this.text,
    required this.num
  });

}
final carquestions = [


Question(
text: 'What type of car is your car? ',
options: [
  Option( text: 'No car',num: 0),
Option( text: 'Gasoline',num:1),
Option( text: 'Hybrid',num: 2),
Option(text: 'Electric',num: 3),

],

),
Question(
text: 'Efficiency ',
options: [
  Option( text: 'No car',num: 0),
  Option(text: '16 L/100km',num: 16),
Option(text: '11 L/100km (Average)',num: 11),

],

),
Question(
text: 'How many km do you drive each week?  ',
options: [
  Option( text: 'No car', num: 0),
  Option(text: '80 km (Rarely)', num:80),
Option(text: '322 km (Average)', num: 322),

],

),
];
final flightsquestions = [
  Question(
    text: 'How many short flights do you take each year?  ',
    options: [
      Option( text: '0', num:0),
      Option(text: '4 roundtrips', num: 4),
      Option(text: '12 roundtrips',num: 12),

    ],

  ),
  Question(
    text: 'How many long flights do you take each year?  ',
    options: [
      Option( text: '0', num: 0),
      Option(text: '2 roundtrips', num: 2),
      Option(text: '4 roundtrips',num: 4),

    ],

  ),
];
final foodquestions = [
  Question(
    text: 'How often do you eat red meat?  ',
    options: [
      Option( text: 'Never (0 servings/week)', num: 0),
      Option(text: 'Couple times a week (2 servings/week)',num: 2),
      Option(text: 'Once a day (7 servings/week)', num: 7),

    ],

  ),
  Question(
    text: 'How often do you have chicken, seafood, or eggs?',
    options: [
      Option( text: 'Never (0 servings/week)',num: 0),
      Option(text: 'Couple times a week (2 servings/week)', num: 2),
      Option(text: 'Once a day (7 servings/week)',num: 7),
      Option(text: 'Many times a day (21 servings/week)',num: 21),

    ],

  ),
  Question(
    text: 'How often do you have milk, cheese, or other dairy products? ',
    options: [
      Option( text: 'Never (0 servings/week)',num: 0),
      Option(text: 'Couple times a week (2 servings/week)',num: 2),
      Option(text: 'Once a day (7 servings/week)', num: 7),
      Option(text: 'Many times a day (21 servings/week)',num: 21),

    ],
  ),
];
final transportsquestions=[
  Question(
    text: 'How much do you travel by bus each week? ',
    options: [
      Option( text: ' Never ',num: 0),
      Option(text: 'Rarely (16 km)', num: 16),
      Option(text: 'Daily commute (32 km)', num: 32),
      Option(text: 'Always (80 km)',num: 80),
    ],
  ),
  Question(
    text: 'How much do you travel by metro each week?  ',
    options: [
      Option( text: ' Never ',num: 0),
      Option(text: 'Rarely (16 km)', num: 16),
      Option(text: 'Daily commute (48 km)', num: 48),
      Option(text: 'Always (80 km)',num: 80),
    ],
  ),
  Question(
    text: 'How much do you travel by inter-city rail each year each week?  ',
    options: [
      Option( text: ' Never ', num: 0),
      Option(text: 'A few short trips a year (322 km) ',num: 322),
      Option(text: 'Between cities often (1609 km) ', num: 1609),
      Option(text: 'Many long trips a year (3219 km) ',num: 3219),
    ],
  ),
];

final shoppingquestions=[
  Question(
    text: 'How much do you spend on furniture and appliances per month?  ',
    options: [
      Option(text: 'A little (175 EGP)',num: 175),
      Option(text: 'Average (375 EGP)',num: 375),
      Option(text: 'A lot (725 EGP) ', num: 725),
    ],
  ),
  Question(
    text: 'How much do you spend on clothes each month? ',
    options: [
      Option(text: 'A little (125 EGP) ',num: 125),
      Option(text: 'Average (400 EGP) ',num: 400),
      Option(text: 'A lot (1200 EGP) ', num:1200),
    ],
  ),
  Question(
    text: 'How much do you spend on all other "stuff" every month? ',
    options: [
      Option(text: 'A little (200 EGP) ',num: 200),
      Option(text: 'Average (575 EGP)',num: 575),
      Option(text: 'A lot (1700 EGP) ',num: 1700),
    ],
  ),
  Question(
    text: 'How much do you spend on services per month?  ',
    options: [
      Option(text: 'A little (825 EGP) ', num: 825),
      Option(text: 'Average (2475 EGP)', num: 2475),
      Option(text: 'A lot (7400 EGP) ',num: 7400),
    ],
  ),
];
final housequestions=[
  Question(
    text: 'How big is your living space? ',
    options: [
      Option( text: 'Small apartment (27 square meters)',num: 27),
      Option(text: 'Average home (36 square meters)',num: 36),
      Option(text: 'Larger home (108 square meters) ',num: 108),


    ],
  ),
  Question(
    text: 'How much electricity do you use per month? ',
    options: [
      Option( text: ' A little (10 kWh/month) ',num: 10),
      Option(text: 'Average (29 kWh/month) ',num: 29),
      Option(text: 'A lot (87 kWh/month) ',num: 87),
    ],
  ),
  Question(
    text: 'How much natural gas do you use?',
    options: [
      Option( text: ' None ( 0  m3 ) ',num: 0),
      Option(text: 'Average ( 2.75 m3) ',num: 2.75),
      Option(text: 'A lot ( 8.24 m3 )',num: 8.24),
    ],
  ),

];

