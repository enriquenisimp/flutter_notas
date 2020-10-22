// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:equatable/equatable.dart';

class TodoEntity implements Equatable{
  final String id;
  final String task;
  final DateTime when;
  final String note;
  final bool complete;
  final String category;
  final List<String> users;

  TodoEntity(this.id, this.task, this.note, this.when, this.complete, this.category, this.users);




  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "task": task,
      "note": note,
    "when": when?.toIso8601String(),
      "complete": complete,
      "category": category,
      "users": users,

    };
  }

  @override
  String toString() {
    return 'TodoEntity{id: $id, task: $task, note: $note, when: $when, complete: $complete, category: $category, users:$users }';
  }

  static TodoEntity fromJson(Map<String, dynamic> json) {
    print("fromjson si");
    return TodoEntity(
      json["id"] as String,
      json["task"] as String,
      json["note"] as String,
      json["when"] == null ? DateTime.now() :DateTime.parse(json["when"] as String)  ,
      json["complete"] as bool,
      json["category"] as String,
      json["users"]?.cast<String>(),

    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [id, task, note, complete, when, category, users];

  @override
  // TODO: implement stringify
  bool get stringify => false;


}
