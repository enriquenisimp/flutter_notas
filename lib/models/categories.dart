import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notas/core/entities/categories_entity.dart';
import 'package:flutter_notas/core/uuid.dart';

class Categories extends Equatable{
  String id;
  String name;
  String color;
  String icon;
  Categories(this.id, this.name, this.color, this.icon);

  Categories copyWith({String id, String name, String color, String icon}) {
    return Categories(
       id ?? this.id,
       name ?? this.name,
       color ?? this.color,
       icon ?? this.icon
    );
  }

  CategoriesEntity toEntity() {
    return CategoriesEntity(id,name, color, icon.toString());
  }

  static Categories fromEntity(CategoriesEntity entity) {
    return Categories(
         entity.id ?? Uuid().generateV4(),
        entity.name,
        entity.color,
        entity.icon,

    );
  }
  @override
  // TODO: implement props
  List<Object> get props => [id, name, color, icon];

  @override
  String toString() {
    // TODO: implement toString
    return 'Categories{ id: $id, name: $name, color:$color, icon: $icon}';
  }


}