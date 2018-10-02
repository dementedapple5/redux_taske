import 'package:flutter_app/models/task.dart';

class GetTasksAction{}

class GetTasksByStateAction{
  bool completed;
  GetTasksByStateAction(this.completed);
}

class AddTaskAction{
  Task task;
  AddTaskAction(this.task);
}

class RemoveTaskAction{
  Task task;
  RemoveTaskAction(this.task);
}

class UpdateTaskAction{
  Task task;
  UpdateTaskAction(this.task);
}