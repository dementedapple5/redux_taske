import 'package:flutter_app/model/task.dart';

class AppState{
  final List<Task> tasks;
  final bool isLoading;

  AppState({this.tasks = const[], this.isLoading});

  AppState copyWith({List<Task> tasks, bool isLoading}) {
    return new AppState(
        tasks: tasks ?? this.tasks,
        isLoading: isLoading ?? this.isLoading
    );
  }

  @override
  String toString() {
    return 'AppState{tasks: $tasks, isLoading: $isLoading}';
  }


}