import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/pages/home_page.dart';
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



    return StoreProvider(
      store: store,
      child: MaterialApp(
          title: 'My App',
          home: HomePage()
      )
    );

  }
}


