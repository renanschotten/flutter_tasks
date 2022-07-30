import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/task_bloc.dart';
import 'models/task_model.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => TaskBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskBloc>();
    bloc.add(GetTask());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          ValueListenableBuilder(
            valueListenable: bloc.listLength,
            builder: (_, int listLength, ___) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      listLength.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TaskSuccess) {
            return state.taskModelList.isNotEmpty
                ? Center(
                    child: ListView.builder(
                      itemCount: state.taskModelList.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.amber,
                            child: ListTile(
                              leading: Text(
                                state.taskModelList[index].id.toString(),
                              ),
                              title: Text(
                                state.taskModelList[index].title,
                              ),
                              subtitle: Text(
                                state.taskModelList[index].description,
                              ),
                              trailing: IconButton(
                                onPressed: () => bloc.add(
                                  RemoveTask(
                                    task: state.taskModelList[index],
                                  ),
                                ),
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                : const Center(
                    child: Text("Lista Vazia"),
                  );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) {
            return Wrap(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                      ),
                      const SizedBox(height: 8.0),
                      TextField(
                        controller: descriptionController,
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: ElevatedButton(
                          onPressed: () {
                            bloc.add(
                              AddTask(
                                task: TaskModel(
                                  description: descriptionController.text,
                                  title: titleController.text,
                                  id: 4,
                                ),
                              ),
                            );
                            descriptionController.text = "";
                            titleController.text = "";
                            Navigator.pop(context);
                          },
                          child: const Text("Save"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
