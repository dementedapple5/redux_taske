import 'package:flutter/material.dart';
import 'package:flutter_app/actions/actions.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/models/task.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';

class AddTaskDialog extends StatefulWidget {
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final int _priority = 1;

  DateTime _initDate;
  DateTime _finalDate;

  DateFormat formatter = DateFormat("dd/MM/yyyy");


  void _selectDate(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: DateTime.now(),
        initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
        firstDate: DateTime(1970),
        lastDate: DateTime(2020));

    if (picked != null && picked.length == 2) {
      setState(() {
        _initDate = picked[0];
        _finalDate = picked[1];
      });
    }
  }


  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnTaskAddedCB>(
      converter: (Store<AppState> store) => (task) => store.dispatch(AddTaskAction(task)),
      builder: (context, callback) {
        return AlertDialog(
          content: Container(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  autofocus: true,
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Task title',
                  ),
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 16.0),
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Task body',
                  ),
                  style: TextStyle(color: Colors.black87, fontSize: 14.0),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.date_range, color: _initDate != null ? Colors.blueAccent : Colors.grey[400]),
              onPressed: () => _selectDate(context),
            ),
            FlatButton(
              child: Text("Save", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w600)),
              onPressed: () {
                callback(saveTask());
              } ,
            )
          ],
        );
      }
    );
  }

  Task saveTask(){
    Task newTask;
    if (_initDate != null && _finalDate != null){
      _initDate = formatter.parse(formatter.format(_initDate));
      _finalDate = formatter.parse(formatter.format(_finalDate));

      newTask = Task(title: _titleController.text, body: _bodyController.text, priority: _priority, initDate: _initDate, finalDate: _finalDate);
    }else{
      newTask = Task(title: _titleController.text, body: _bodyController.text, priority: _priority);
    }

    return newTask;
  }

}

typedef OnTaskAddedCB = Function(Task task);


