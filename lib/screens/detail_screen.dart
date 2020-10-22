import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notas/bloc/todos/todos_bloc.dart';
import 'package:flutter_notas/bloc/todos/todos_event.dart';
import 'package:flutter_notas/bloc/todos/todos_state.dart';
import 'package:flutter_notas/flutter_todos_keys.dart';
import 'package:flutter_notas/models/todo.dart';
import 'package:flutter_notas/widgets/timer.dart';

import 'add_todo_screen.dart';

class DetailScreen extends StatelessWidget {
  final String id;

  const DetailScreen({Key key, @required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodoState>(
      builder: (context, state) {
        final todo = (state as TodosLoadSuccess)
            .todos
            .firstWhere((todo) => todo.id == id, orElse: () => null);

        return Scaffold(
          appBar: AppBar(
            title: Text("Detail TODO"),
            actions: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<TodosBloc>(context).add(TodoDeleted(todo));
                  Navigator.pop(context, todo);
                },
              )
            ],
          ),
          body: todo == null
              ? Container(key: FlutterTodosKeys.emptyDetailsContainer)
              : ListView(
            scrollDirection: Axis.vertical,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              value: todo.complete,
                              onChanged: (_) {
                                BlocProvider.of<TodosBloc>(context).add(
                                    TodoUpdated(todo.copyWith(
                                        complete: !todo.complete)));
                              },
                            ),
                          ),
                          Hero(
                            tag: '${todo.id}__heroTag',
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                todo.task,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          )
                        ]),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            height: 30,
                            color: Colors.white38,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.today,
                                    color: Theme.of(context).accentColor,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  MyTime(time: todo.when, size: 18.0)
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 30,
                            color: Colors.white38,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            todo.note,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: 70,
                          ),


                        ],
                      ),
                    ),
                    todo.users==null
                        ? Container(key: FlutterTodosKeys.emptyDetailsContainer)
                        : Column(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                            children: [
                              SizedBox(
                                width: 5.0,
                                height: 25.0,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "With",
                                  style: TextStyle(
                                    fontSize: 27,
                                  ),
                                ),
                              ),
                            ],
                    ),
                         ),
                         SizedBox(
                           height: 150,
                           child:ListView.builder(
                              itemCount: todo.users.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context,int item) {
                                return  Card(
                                    child: Container(
                                      width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5.0),
                                            decoration:BoxDecoration(
                                              borderRadius:BorderRadius.circular(50),
                                              gradient: new LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromARGB(255, 25,178,238),
                                                  Color.fromARGB(255, 21,236,229)
                                                ],
                                              )
                                            ),
                                            child: Icon(Icons.person, size: 50,)),
                                        SizedBox(height: 10),
                                        Text(todo.users[item], style: Theme.of(context).textTheme.headline6,),
                                      ],
                                    ),
                                  ),
                                ));
                              },
                            ),
                         ),
                       ],
                     ),

                  ],
                ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: todo == null
                ? null
                : () {
                    Navigator.of(context).push(
                  MaterialPageRoute(builder:
                      (BuildContext context) {
                      return AddTodoScreen(

                        onSave: (task, note, when, category){
                          BlocProvider.of<TodosBloc>(context)..add(
                              TodoUpdated(
                                  todo.copyWith(task:task, when:when, note:note, category: category)
                              )
                          );
                        },
                        todo: todo,
                        isEditing: true,
                      );
                      }

                  )
                );
                  },
          ),
        );
      },
    );
  }
}
