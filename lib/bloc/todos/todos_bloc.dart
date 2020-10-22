import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notas/bloc/todos/todos_event.dart';
import 'package:flutter_notas/bloc/todos/todos_state.dart';
import 'package:flutter_notas/models/todo.dart';
import 'package:flutter_notas/repository_core/repository.dart';

class TodosBloc extends Bloc<TodosEvent, TodoState>{

  final TodosRepositoryFlutter todosRepository;
  TodosBloc({@required this.todosRepository}) : super(TodosLoadInProgress());

  @override
  Stream<TodoState> mapEventToState(TodosEvent event) async*{

    if (event is TodoLoaded) { yield* _mapTodosLoadedToState();}
    else if(event is TodoAdded) {yield* _mapTodoAddedToState(event);}
    else if(event is TodoUpdated) {yield* _mapTodoUpdatedToState(event);}
    else if(event is TodoDeleted) {yield* _mapTodoDeletedToState(event);}
    else if(event is ToggleAll) {yield* _mapToggleAllToState();}
    else if(event is ClearCompleted) {yield* _mapClearCompletedToState();}
  }

  Stream<TodoState> _mapTodosLoadedToState() async*{

    try{
      final todos= await todosRepository.loadTodos();
      yield TodosLoadSuccess(
        todos.map(Todo.fromEntity).toList(),
      );
    }catch(_){
      yield TodosLoadFailure();
    };
  }

  Stream<TodoState> _mapTodoAddedToState(TodoAdded event) async*{
  print("ok start");
    if(state is TodosLoadSuccess){
      print("success");
      final List<Todo> updatetodo=
          List.from((state as TodosLoadSuccess).todos)..add(event.todo);
      yield TodosLoadSuccess(updatetodo);
      _saveTodos(updatetodo);
    }
  }

  Stream<TodoState> _mapTodoUpdatedToState(TodoUpdated event) async*{
    if(state is TodosLoadSuccess){
      final List<Todo> updateTodos=
      (state as TodosLoadSuccess).todos.map((todo) {
                return todo.id == event.todo.id ? event.todo : todo;
              }).toList();
      yield TodosLoadSuccess(updateTodos);
      _saveTodos(updateTodos);
    }
  }
  Stream<TodoState> _mapTodoDeletedToState(TodoDeleted event) async*{
    if(state is TodosLoadSuccess){
      final List<Todo> updatedTodos=
      (state as TodosLoadSuccess)
          .todos.where((todo)=>todo.id !=event.todo.id).toList();
      yield TodosLoadSuccess(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }
  Stream<TodoState> _mapToggleAllToState() async* {
    if (state is TodosLoadSuccess) {
      final allComplete =
      (state as TodosLoadSuccess).todos.every((todo) => todo.complete);
      final List<Todo> updatedTodos = (state as TodosLoadSuccess)
          .todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      yield TodosLoadSuccess(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodoState> _mapClearCompletedToState() async* {
    if (state is TodosLoadSuccess) {
      final List<Todo> updatedTodos = (state as TodosLoadSuccess)
          .todos
          .where((todo) => !todo.complete)
          .toList();
      yield TodosLoadSuccess(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    print("try to save data");
    return todosRepository.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }

}