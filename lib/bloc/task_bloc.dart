import 'package:bloc/bloc.dart';
import 'package:bloc_list/models/task_model.dart';
import 'package:flutter/cupertino.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final List<TaskModel> taskModelList = [];

  ValueNotifier<int> listLength = ValueNotifier<int>(0);

  TaskBloc() : super(TaskInitial()) {
    on<AddTask>((event, emit) async {
      emit(TaskLoading());
      await Future.delayed(const Duration(milliseconds: 100));
      taskModelList.add(event.task);
      listLength.value = taskModelList.length;
      emit(TaskSuccess(taskModelList: taskModelList));
    });

    on<RemoveTask>((event, emit) async {
      emit(TaskLoading());
      await Future.delayed(const Duration(milliseconds: 100));
      taskModelList.removeWhere((element) => element == event.task);
      listLength.value = taskModelList.length;
      emit(TaskSuccess(taskModelList: taskModelList));
    });

    on<GetTask>((event, emit) async {
      emit(TaskLoading());
      await Future.delayed(const Duration(milliseconds: 100));
      listLength.value = taskModelList.length;
      emit(TaskSuccess(taskModelList: taskModelList));
    });
  }
}
