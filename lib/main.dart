import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notas/bloc/category/category_bloc.dart';
import 'package:flutter_notas/bloc/category/category_event.dart';
import 'package:flutter_notas/bloc/filtered_todos/filtered_todos.dart';
import 'package:flutter_notas/bloc/simple_bloc_observer.dart';
import 'package:flutter_notas/bloc/todos/todos_bloc.dart';
import 'package:flutter_notas/core/routes.dart';
import 'package:flutter_notas/core/todo_repository.dart';
import 'package:flutter_notas/keys.dart';
import 'package:flutter_notas/models/todo.dart';
import 'package:flutter_notas/repository_core/file_storage.dart';
import 'package:flutter_notas/repository_core/repository.dart';
import 'package:flutter_notas/screens/add_todo_screen.dart';
import 'package:flutter_notas/screens/home_screen.dart';
import 'file:///C:/Users/qdsoft/Escritorio/flutter_notas/lib/screens/list_todos.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/tab/tab.dart';
import 'bloc/todos/todos_event.dart';
import 'materials/themes.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(BlocProvider(
    create: (context) {
      return TodosBloc(
          todosRepository: TodosRepositoryFlutter(
              fileStorage: FileStorage(
                  "__flutter_app__", getApplicationDocumentsDirectory)))
        ..add(TodoLoaded());
    },
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Notes', theme: Themes.theme, routes: {
      Routes.home: (context) {
        return BlocProvider(
          create: (context) => CategoryBloc(
              catRepository: TodosRepositoryFlutter(
                  fileStorage: FileStorage(
                      "__flutter_app__", getApplicationDocumentsDirectory))
          )..add(CategoryLoaded()),
          child: HomeScreen(),
        );
      },
      Routes.listTodos:(context){
        return BlocProvider(
          create: (context)=> FilteredTodosBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context)
          ),
          child: ListTodos(),
        );
      },
      Routes.addTodo:(context){
        return AddTodoScreen(
          onSave: (task, note, when, category){
            BlocProvider.of<TodosBloc>(context)..add(
              TodoAdded(
                Todo(task:task, when:when, note:note, category: category)
              )
            );
          },
          isEditing: false,
        );
      }
    });
  }
}
