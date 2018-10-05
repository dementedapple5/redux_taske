import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:flutter_app/actions/actions.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/models/task.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:redux/redux.dart';


List<String> users = [
  "Daniel",
  "David",
  "Carlos",
  "carla",
  "Cadamio"
];



class AddRequestPage extends StatefulWidget {
  @override
  _AddRequestPageState createState() => _AddRequestPageState();
}

class _AddRequestPageState extends State<AddRequestPage> {

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final dateSection = DateSection();
    final descSection = DescSection(titleController: _titleController, bodyController: _bodyController);
    final customSlider = CustomSlider();

    return Scaffold(
      appBar: AppBar(title: Text("Submit a Request")),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              descSection,
              Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
              dateSection,
              Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
              customSlider,
              Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
              StoreConnector<AppState, OnRequestAddedCB>(
                converter: (Store store) => (task) => store.dispatch(AddTaskAction),
                builder: (BuildContext context, OnRequestAddedCB cb) {
                  RaisedButton(
                    shape: StadiumBorder(),
                    color: Colors.blue,
                    child: Text("Send Request", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      final task = Task(
                          title: descSection.titleController.text,
                          body: descSection.bodyController.text,
                          priority: customSlider.createState().sliderValue.round());
                      print(task);
                      cb(task);
                    }
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}


class DescSection extends StatelessWidget {

  final TextEditingController titleController;
  final TextEditingController bodyController;


  DescSection({this.titleController, this.bodyController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: Text("Description", style: TextStyle(fontWeight: FontWeight.w600))
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: "Title"
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
              ),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(
                    hintText: "Body"
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class DateSection extends StatefulWidget {
  @override
  _DateSectionState createState() => _DateSectionState();
}

class _DateSectionState extends State<DateSection> {

  final _dateFormatter = DateFormat("dd/MM/yyyy");

  String initDate;
  String finalDate;


  void _selectDate(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: DateTime.now(),
        initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
        firstDate: DateTime(1970),
        lastDate: DateTime(2020));

    if (picked != null && picked.length == 2) {
      setState(() {
        initDate = _dateFormatter.format(picked[0]);
        finalDate = _dateFormatter.format(picked[1]);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: Text("Date Range", style: TextStyle(fontWeight: FontWeight.w600))
        ),
        InkWell(
          child: ListTile(
            leading: Icon(Icons.date_range, color: finalDate == null ? Colors.grey[400] : Colors.blueAccent),
            title: Text(finalDate == null ? "Select a date range" : "$initDate to $finalDate"),
          ),
          onTap: () => _selectDate(context),
        ),
      ],
    );
  }
}




class CustomSlider extends StatefulWidget {

  @override
  CustomSliderState createState() {
    return new CustomSliderState();
  }
}

class CustomSliderState extends State<CustomSlider> {

  double sliderValue = 1.0;
  final _maxSliverValue = 3.0;
  Color _currentColor = Colors.green;
  IconData _currentIcon = Icons.filter_1;

  _switchColor(double value){
    if (value == 1.0){
      _currentColor = Colors.green;
      _currentIcon = Icons.filter_1;
    }
    else if (value == 2.0){
      _currentColor = Colors.orange;
      _currentIcon = Icons.filter_2;
    }
    else if (value == 3.0){
      _currentColor = Colors.redAccent;
      _currentIcon = Icons.filter_3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("Priority", style: TextStyle(fontWeight: FontWeight.w600)),
          trailing: Icon(_currentIcon, color: _currentColor),
        ),
        Slider(
          onChanged: (double value) {
            setState(() {
              sliderValue = value;
              _switchColor(value);
            });
          },
          value: sliderValue,
          min: 1.0,
          max: _maxSliverValue,
          divisions: 2,
          activeColor: _currentColor,
          label: sliderValue.round().toString(),
        )
      ],
    );
  }
}

class SearchTargetSection extends StatefulWidget {
  @override
  _SearchTargetSectionState createState() => _SearchTargetSectionState();
}

class _SearchTargetSectionState extends State<SearchTargetSection> {

  final textFieldConf = TextFieldConfiguration(
    decoration: InputDecoration(
      hintText: "Search user"
    )
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TypeAheadField(
        textFieldConfiguration: textFieldConf,
        onSuggestionSelected: (suggestion) {},
        suggestionsCallback: (String pattern) {
          return List.of(users)..where((username) => username.contains(pattern));
        },
        itemBuilder: (BuildContext context, itemData) {
          return ListTile(
            title: Text(itemData),
          );
        },

      ),
    );
  }
}

typedef OnRequestAddedCB = Function(Task task);


