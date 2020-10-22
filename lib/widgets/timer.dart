import 'package:flutter/material.dart';
class MyTime extends StatelessWidget {
  final DateTime time;
  final double size;
  const MyTime({Key key, this.time, this.size}) : super(key: key);
   @override
   Widget build(BuildContext context) {
     return Text(
         timeindays(time),
       style: TextStyle(
         fontSize: size
       ),
     );
   }
 }


 String timeindays(DateTime mytime){
  DateTime auxtime=DateTime.now();
  if(mytime.year==auxtime.year)
      {
        if(mytime.month==auxtime.month) {
          if(mytime.day==auxtime.day){return "Today";}
          else if(mytime.day<auxtime.day){
            var rest=auxtime.day-mytime.day;
            return "It was $rest day/s ago";
          }else{
            var rest=mytime.day-auxtime.day;
            return "In $rest day/s";}
        }
        else{return "${mytime.day}/${mytime.month}/${mytime.year}";}
      }else{return "${mytime.day}/${mytime.month}/${mytime.year}";}
  }
