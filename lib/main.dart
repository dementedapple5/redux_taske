import 'dart:async';

import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_app/reducers/app_reducer.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {

  final store = Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: []
  );

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'My App',
      home: HomePage()
    );

  }
}

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  DateTime _initDate = DateTime.now();
  DateTime _finalDate = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();


  void _selectDate(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: DateTime.now(),
        initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
        firstDate: DateTime(1996),
        lastDate: DateTime(2019));

    if (picked != null && picked.length == 2) {
      setState(() {
        _initDate = picked[0];
        _finalDate = picked[1];
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    String range = "${_initDate.year}/${_initDate.month}/${_initDate.day} - ${_finalDate.year}/${_finalDate.month}/${_finalDate.day}";

    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                  range,
                  style: TextStyle(fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                      color: Colors.blue)),
            ),
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
        child: Icon(Icons.date_range),
        onPressed: () => _selectDate(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
