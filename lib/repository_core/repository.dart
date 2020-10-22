
import 'package:flutter/cupertino.dart';
import 'package:flutter_notas/core/category_repository.dart';
import 'package:flutter_notas/core/entities/categories_entity.dart';
import 'package:flutter_notas/core/entities/todo_entity.dart';
import 'package:flutter_notas/core/todo_repository.dart';
import 'package:flutter_notas/models/categories.dart';
import 'package:flutter_notas/repository_core/file_storage.dart';
import 'package:flutter_notas/repository_core/web_client.dart';

class TodosRepositoryFlutter implements TodosRepository, CategoryRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  TodosRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient()});

  @override
  Future<List<TodoEntity>> loadTodos() async {
    // TODO: implement loadTodos
  try{
    print("get todos from json");

    return await fileStorage.loadTodos();
 }catch(e){
    print("get todos from wclient ${e.toString()}");

    final todos =await webClient.fetchTodos();
    fileStorage.saveTodos(todos);
    return todos;
  }
  }

  @override
  Future saveTodos(List<TodoEntity> todos) async {
    // TODO: implement saveTodos
    return Future.wait([
      fileStorage.saveTodos(todos),
      webClient.postTodos(todos)
    ]);

  }
  @override
  Future<List<CategoriesEntity>> loadCategories() async {
    try{
      print("get category from json");
      return await fileStorage.loadCategories();
    }catch(e){
      print("get category from webclient ${e.toString()}");

      final todos =await webClient.fetchCategory();
      fileStorage.saveCategories(todos);
      return todos;
    };
  }

  @override
  // Persists todos to local disk and the web
  Future saveCategories(List<CategoriesEntity> category){
    return Future.wait([
      fileStorage.saveCategories(category),
      webClient.postCategories(category)
    ]);
  }
  
}