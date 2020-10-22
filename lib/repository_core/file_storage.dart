// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_notas/core/entities/categories_entity.dart';
import 'package:flutter_notas/core/entities/todo_entity.dart';
import 'package:flutter_notas/models/categories.dart';

/// Loads and saves a List of Todos using a text file stored on the device.
///
/// Note: This class has no direct dependencies on any Flutter dependencies.
/// Instead, the `getDirectory` method should be injected. This allows for
/// testing.
class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
    this.tag,
    this.getDirectory,
  );
  @override
  Future<List<TodoEntity>> loadTodos() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    print(" datoos ${string}");
    final json = JsonDecoder().convert(string);

    final todos = (json['todos'])
        .map<TodoEntity>((todo) => TodoEntity.fromJson(todo))
        .toList();
    print("ahora si");

    return todos;
  }
  @override
  Future<List<CategoriesEntity>> loadCategories() async {
    final file = await _getLocalFileCatefories();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final cat = (json['categories'])
        .map<CategoriesEntity>((categories) => CategoriesEntity.fromJson(categories))
        .toList();

    return cat;
  }
@override
  Future<File> saveTodos(List<TodoEntity> todos) async {
    final file = await _getLocalFile();
    return file.writeAsString(JsonEncoder().convert({
      'todos': todos.map((todo) => todo.toJson()).toList(),
    }));
  }

  @override
  Future<File> saveCategories(List<CategoriesEntity> categories) async {
    final file = await _getLocalFileCatefories();
    return file.writeAsString(JsonEncoder().convert({
      'categories': categories.map((categorie) => categorie.toJson()).toList(),
    }));
  }
  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/todolist_$tag.json');
  }

  Future<File> _getLocalFileCatefories() async {
    final dir = await getDirectory();
    return File('${dir.path}/catlist_$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }

  Future<FileSystemEntity> cleancategory() async {
    final file = await _getLocalFileCatefories();

    return file.delete();
  }
}
