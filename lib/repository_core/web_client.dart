// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_notas/core/entities/categories_entity.dart';
import 'package:flutter_notas/core/entities/todo_entity.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Todos to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WebClient {
  final Duration delay;

  const WebClient([this.delay = const Duration(milliseconds: 0)]);

  /// Mock that "fetches" some Todos from a "web service" after a short delay
  Future<List<TodoEntity>> fetchTodos() async {
    return Future.delayed(
        delay,
        () => [
              TodoEntity('1', 'Buy food for da kitty',
                  'With the chickeny bits!',  DateTime.now(), false, "0", ["Andrew", "Henry", "Michel"]),
              TodoEntity('2', 'Find a Red Sea dive trip', 'Echo vs MY Dream',
                  null, false, "0", ["Andrew", "Henry", "Michel"]),
              TodoEntity('3', 'Book flights to Egypt', '',  DateTime.now(), true, "0",["Lucas", "Kevin", "Henry"]),
              TodoEntity(
                  '4', 'Decide on accommodation', '', DateTime.now(), false, "0", ["Matt", "Michel", "Adrian"]),
              TodoEntity(
                  '5', 'Sip Margaritas', 'on the beach', DateTime.now(), true, "0", ["Adrian", "Kevin", "Matt"]),
              TodoEntity('6', 'Burger in chirstmas', 'on the plane',  DateTime.now(),
                  true, "0", ["Andrew", "Henry", "Michel"]),
            ]);
  }

  Future<List<CategoriesEntity>> fetchCategory() async {
    return Future.delayed(
        delay,
        () => [
          CategoriesEntity(
                  '0', 'My day', 'E219F3', "sunny"),
          CategoriesEntity(
                  '1', 'Planned', '38C10F', "car"),
          CategoriesEntity(
                  '2', 'Important', 'F3F319', "star"),
          CategoriesEntity(
                  '3', 'Tasks', 'F3194B', "edit"),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postTodos(List<TodoEntity> todos) async {
    return Future.value(true);
  }
  Future<bool> postCategories(List<CategoriesEntity> category) async {
    return Future.value(true);
  }
}
