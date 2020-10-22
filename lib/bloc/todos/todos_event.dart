import 'package:equatable/equatable.dart';
import 'file:///C:/Users/qdsoft/Escritorio/flutter_notas/lib/core/entities/todo_entity.dart';
import 'package:flutter_notas/models/todo.dart';

// This class is responsable of all the events that it allowed in this app.

class TodosEvent extends Equatable{
  //For start we declare the prototype of construct that will be override for every subclass that need it
  const TodosEvent();

  //And Implements the prototype of ListObjects method of Equatable, that Like the constructor,
  // will be override for the predecessor.
  @override
  // TODO: implement props
  List<Object> get props => [];

}

//This method ocurred when THe list is completed, not exist any override
// and any change in the data, for this reason don't need be touched
class TodoLoaded extends TodosEvent{}

//This method add other item into the list, for this reason it
// need all the information about the item, the object, in this case, TodoObject
class TodoAdded extends TodosEvent{
final Todo todo;

  TodoAdded(this.todo);

@override
  List<Object> get props =>[todo];

@override
String toString() => 'TodoAdded { todo: $todo }';
}

//This method allow us to change any variable of any item, for this reason need to provided
// what item need to change, and create a comparative with the objects that it have
class TodoUpdated extends TodosEvent{
  final Todo todo;

  TodoUpdated(this.todo);

  @override
  List<Object> get props =>[todo];

  @override
  String toString() => 'TodoUpdated { updatedTodo: $todo }';
}
class TodoDeleted extends TodosEvent{
  final Todo todo;

  const TodoDeleted(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoDeleted { todo: $todo }';
}
class ClearCompleted extends TodosEvent {}

class ToggleAll extends TodosEvent {}