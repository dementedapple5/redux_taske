import 'package:flutter_app/actions/actions.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/models/task.dart';

AppState appReducer(AppState state, dynamic action){
  return AppState(
    isLoading: false,
    tasks: taskReducer(state.tasks, action)
  );

}

List<Task> taskReducer(List<Task> tasks, dynamic action){
  if (action is AddTaskAction) {
    return addTask(tasks, action);
  }
  else if (action is RemoveTaskAction) {
    return removeTask(tasks, action);
  }
  else if (action is UpdateTaskAction) {
    return updateTask(tasks, action);
  }

  return tasks;
}



List<Task> addTask(List<Task> tasks, AddTaskAction action){
  return List.of(tasks)..add(action.task);
}

List<Task> removeTask(List<Task> tasks, RemoveTaskAction action){
  return List.of(tasks)..remove(action.task);
}

List<Task> updateTask(List<Task> tasks, UpdateTaskAction action){
  return List.of(tasks).map((task) => task.id == action.task.id ? action.task : task).toList();
}