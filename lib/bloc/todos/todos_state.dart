import 'package:equatable/equatable.dart';
import 'package:flutter_notas/models/todo.dart';

//This class contain all the states that have in this bloc, since waiting any answer until have a good or bad request
class TodoState extends Equatable{
  const TodoState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TodosLoadInProgress extends TodoState{

}

class TodosLoadSuccess extends TodoState{
  final List<Todo> todos;

  TodosLoadSuccess([this.todos = const[]]);

  @override
  List<Object> get props=>[todos];

  @override
  String toString() => 'TodosLoadSuccess { todos: $todos }';
}

class TodosLoadFailure extends TodoState{

}