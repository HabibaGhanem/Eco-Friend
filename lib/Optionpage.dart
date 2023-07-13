import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Data.dart';
// create options

class OptionWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> OnClickedOption;
  const OptionWidget({
    Key? key,
    required this.question,
    required this.OnClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)=> SingleChildScrollView(
    child: Column( children: question.options.map((option) => buildoption ( context , option)).toList(),
    ),
  );




  Widget buildoption(BuildContext context, Option option) {
    final col= colorchanged(option, question);
    return GestureDetector(
      onTap: () => OnClickedOption(option),

      child: Container(
        height: 50,

        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 5),
        decoration: BoxDecoration(
          color: col,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [ BoxShadow(
            color: Colors.grey,
            offset: const Offset(
              2.0,
              2.0,
            ),
            blurRadius: 6.0,
            spreadRadius: 1.0,
          ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
            ],

        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              option.text,
                style: GoogleFonts.getFont('Lato',
                  fontSize: 18,
                ) ,
            ),
          ],
        ),
      ),

    );

  }

  Color colorchanged(Option option, Question question) {
    final isselected=option== question.selectedOption;
    if(! isselected){

      return  Colors.white;

    }
    else{


      return Colors.cyan.shade700;//
    }
  }
}
