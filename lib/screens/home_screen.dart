import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notas/bloc/filtered_todos/filtered_todos.dart';
import 'package:flutter_notas/bloc/tab/tab_bloc.dart';
import 'package:flutter_notas/bloc/todos/todos_bloc.dart';
import 'package:flutter_notas/bloc/todos/todos_state.dart';
import 'package:flutter_notas/core/routes.dart';
import 'package:flutter_notas/models/app_tab.dart';
import 'package:flutter_notas/screens/list_category_todo.dart';
import '../keys.dart';



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
    appBar: AppBar(
    title: Text("To-do List"),
    ),
    body: ListCategoryTodo()
    /*floatingActionButton: FloatingActionButton.extended(
      key: ArchSampleKeys.addTodoFab,
      label:Text("New List"),
      onPressed: () {
      Navigator.pushNamed(context, Routes.addTodo);
      },
      icon: Icon(Icons.add),
    // tooltip: ArchSampleLocalizations.of(context).addTodo,
    ),
    );*/

    );
}
}
