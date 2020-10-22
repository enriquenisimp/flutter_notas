import 'package:flutter/material.dart';
import 'package:flutter_notas/core/entities/categories_entity.dart';
import 'package:flutter_notas/core/todo_repository.dart';
import 'package:flutter_notas/models/categories.dart';
import 'package:flutter_notas/repository_core/file_storage.dart';
import 'package:flutter_notas/repository_core/web_client.dart';

abstract class CategoryRepository{

  Future<List<CategoriesEntity>> loadCategories();
  // Persists todos to local disk and the web
  Future saveCategories(List<CategoriesEntity> category);
}