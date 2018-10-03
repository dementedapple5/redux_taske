import 'package:flutter/material.dart';
import 'package:flutter_app/containers/add_task_sheet.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.menu), onPressed: () {},),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {},),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showDialog(
            context: context,
            builder: (context) {
              return AddTaskDialog();
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}