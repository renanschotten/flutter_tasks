// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class AddTask extends TaskEvent {
  TaskModel task;

  AddTask({
    required this.task,
  });
}

class RemoveTask extends TaskEvent {
  TaskModel task;

  RemoveTask({
    required this.task,
  });
}

class GetTask extends TaskEvent {}
