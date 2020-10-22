import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notas/bloc/category/category_event.dart';
import 'package:flutter_notas/bloc/category/category_state.dart';
import 'package:flutter_notas/bloc/todos/todos_event.dart';
import 'package:flutter_notas/bloc/todos/todos_state.dart';
import 'package:flutter_notas/core/category_repository.dart';
import 'package:flutter_notas/models/categories.dart';
import 'package:flutter_notas/models/todo.dart';
import 'package:flutter_notas/repository_core/repository.dart';

  class CategoryBloc extends Bloc<CategoryEvent, CategoryState>{

  final CategoryRepository catRepository;
  CategoryBloc({@required this.catRepository}) : super(CategoryLoadInProgress());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async*{
    print("hello");
    if (event is CategoryLoaded) { yield* _mapCategoryLoadedToState();}
    else if(event is CategoryAdded) {yield* _mapCategoryAddedToState(event);}
    else if(event is CategoryUpdated) {yield* _mapCategoryUpdatedToState(event);}
    else if(event is CategoryDeleted) {yield* _mapCategoryDeletedToState(event);}
  }

  Stream<CategoryState> _mapCategoryLoadedToState() async*{

    try{
      final category= await catRepository.loadCategories();
      yield CategoryLoadSuccess(
        category.map(Categories.fromEntity).toList(),
      );
    }catch(_){
      yield CategoryLoadFailure();
    };
  }

  Stream<CategoryState> _mapCategoryAddedToState(CategoryAdded event) async*{
  print("ok start");
    if(state is CategoryLoadSuccess){
      print("success");
      final List<Categories> updatetodo=
          List.from((state as CategoryLoadSuccess).category)..add(event.category);
      yield CategoryLoadSuccess(updatetodo);
      _saveTodos(updatetodo);
    }
  }

  Stream<CategoryState> _mapCategoryUpdatedToState(CategoryUpdated event) async*{
    if(state is CategoryLoadSuccess){
      final List<Categories> updateTodos=
      (state as CategoryLoadSuccess).category.map((category) {
                return category.id == event.category.id ? event.category : category;
              }).toList();
      yield CategoryLoadSuccess(updateTodos);
      _saveTodos(updateTodos);
    }
  }
  Stream<CategoryState> _mapCategoryDeletedToState(CategoryDeleted event) async*{
    if(state is CategoryLoadSuccess){
      final List<Categories> updatedTodos=
      (state as CategoryLoadSuccess)
          .category.where((category)=>category.id !=event.category.id).toList();
      yield CategoryLoadSuccess(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }


  Future _saveTodos(List<Categories> categories) {
    print("try to save data");
    return catRepository.saveCategories(
        categories.map((cat) => cat.toEntity()).toList(),
    );
  }

}