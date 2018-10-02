import 'package:meta/meta.dart';

class Task{

  String id;
  String title;
  String body;
  int priority;
  DateTime initDate;
  DateTime finalDate;
  bool completed;

  Task({
    @required this.title,
    @required this.body,
    @required this.priority,
    this.initDate,
    this.finalDate,
    this.completed = false
  });

  Task.fromJson(Map<String, dynamic> json)
      :
        this.title = json["title"],
        this.body = json["body"],
        this.initDate = json["init_date"],
        this.finalDate = json["final_date"],
        this.completed = json["completed"];


  String getRange(){
    String range = "${initDate.year}/${initDate.month}/${initDate.day} - ${finalDate.year}/${finalDate.month}/${finalDate.day}";
    return range;
  }

  int getDaysLeft(){
    int daysLeft = finalDate.difference(initDate).inDays;
    return daysLeft;
  }



}