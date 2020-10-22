import 'package:equatable/equatable.dart';
import 'package:flutter_notas/core/entities/todo_entity.dart';
import 'package:flutter_notas/core/uuid.dart';

class Todo extends Equatable {
  final bool complete;
  final String id;
  final String note;
  final String task;
  final DateTime when;
  final String category;
  final List<String> users;
  Todo(
    {
      String id,
      this.task,
      String note = '',
      DateTime when,
      this.complete = false,
      this.category,
      this.users
  })  : this.note = note ?? '',
        this.id = id ?? Uuid().generateV4(),
        this.when= when ?? DateTime.now();

  Todo copyWith({bool complete, String id, String note, String task, DateTime when, String category, List<String> users}) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      note: note ?? this.note,
      when: when ?? this.when,
      complete: complete ?? this.complete,
      category: category ?? this.category,
      users: users ?? this.users,

    );
  }

  @override
  List<Object> get props => [id, task, note, when, complete, category, users];

  @override
  String toString() {
    return 'Todo { id: $id,  task: $task, note: $note, when:$when, complete: $complete, category: $category, users: $users }';
  }

  TodoEntity toEntity() {
    return TodoEntity(id,task, note, when ?? DateTime.now() ,complete, category, users);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      id: entity.id ?? Uuid().generateV4(),
      task:entity.task,
      note: entity.note,
      when: entity.when ?? DateTime.now(),
      complete: entity.complete ?? false,
      category: entity.category,
      users: entity.users

    );
  }
}
