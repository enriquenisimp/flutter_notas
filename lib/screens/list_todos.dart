import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notas/bloc/filtered_todos/filtered_todos_bloc.dart';
import 'package:flutter_notas/bloc/filtered_todos/filtered_todos_state.dart';
import 'package:flutter_notas/bloc/todos/todos_bloc.dart';
import 'package:flutter_notas/bloc/todos/todos_event.dart';
import 'package:flutter_notas/bloc/todos/todos_state.dart';
import 'package:flutter_notas/core/routes.dart';
import 'package:flutter_notas/models/categories.dart';
import 'package:flutter_notas/screens/detail_screen.dart';
import 'package:flutter_notas/widgets/empty.dart';
import 'package:flutter_notas/widgets/loading_indicator.dart';
import 'package:flutter_notas/widgets/todo_item.dart';
import '../flutter_todos_keys.dart';
import '../keys.dart';

class ListTodos extends StatelessWidget {
  ListTodos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Categories args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("List To do"),
      ),
      body: BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
        builder: (context, states) {
          if (states is FilteredTodosLoadInProgress) {
            return LoadingIndicator(key: ArchSampleKeys.todosLoading);
          } else if (states is FilteredTodosLoadSuccess) {
            final todos = states.filteredTodos.where((todo) => args.id==todo.category).toList();
            print("length: ${todos.length}");
            if(todos.length != 0 )
              {
                return ListView.builder(
                  key: ArchSampleKeys.todoList,
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final todo = todos[index];

                    if(todos.length==0)
                    {
                      return Container(key: FlutterTodosKeys.filteredTodosEmptyContainer ,
                          child: Center(
                            child: Image.asset("images/empty.png"),
                          ));
                    }else{
                      return TodoItem(
                        todo: todo,
                        onDismissed: (direction) {
                          BlocProvider.of<TodosBloc>(context).add(TodoDeleted(todo));

                        },
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return DetailScreen(id: todo.id);
                            }),
                          );

                        },
                        onCheckboxChanged: (_) {
                          BlocProvider.of<TodosBloc>(context).add(
                            TodoUpdated(todo.copyWith(complete: !todo.complete)),
                          );
                        },
                      );
                    }
                  },
                );
              }else{
              return EmptyList();
            }
          } else {
            return EmptyList();
          }
        },
      ),
    floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, Routes.addTodo, arguments: args.id);

        }, label: Text("New Task")),);
  }
}
