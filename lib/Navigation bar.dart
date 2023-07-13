import 'package:flutter/material.dart';
import 'package:graduation_project_app/information_page.dart';
import 'HabitsPage.dart';
import 'News_screen.dart';
import 'Tips.dart';

import 'package:graduation_project_app/Calculator.dart';
import 'Data.dart';
import 'Optionpage.dart';
import 'Results page.dart';
import 'ProfilePage.dart';
import 'HomeScreen.dart';
import 'HabitsMainPage.dart';
int pageIndex=0;
Container buildMyNavBar(BuildContext context) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.cyan.shade800,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          enableFeedback: false,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Homescreen()));
          },
          icon: pageIndex == 0
              ? const Icon(
            Icons.home_filled,
            color: Colors.white,
            size: 30,
          )

              : const Icon(
            Icons.home_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
        IconButton(
          enableFeedback: false,

          icon: pageIndex == 1
              ? const Icon(
            Icons.calculate,
            color: Colors.white,
            size: 30,
          )
              : const Icon(
            Icons.calculate_outlined,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyApp()));
          },
        ),

        IconButton(
          enableFeedback: false,

          icon: pageIndex == 3
              ? const Icon(
            Icons.newspaper,
            color: Colors.white,
            size: 30,
          )
              : const Icon(
            Icons.newspaper_outlined,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsScreen()));
          },
        ),
        IconButton(
          enableFeedback: false,

          icon: pageIndex == 3
              ? const Icon(
            Icons.calendar_month,
            color: Colors.white,
            size: 30,
          )
              : const Icon(
            Icons.calendar_month_outlined,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => seletscreen()));
          },
        ),
        IconButton(
          enableFeedback: false,

          icon: pageIndex == 4
              ? const Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          )
              : const Icon(
            Icons.person_outline,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage1()));
          },
        ),
        IconButton(
          enableFeedback: false,

          icon: pageIndex == 5
              ? const Icon(
            Icons.info,
            color: Colors.white,
            size: 30,
          )
              : const Icon(
            Icons.info_outline,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => information_page()));
          },
        ),
      ],
    ),

  );
}