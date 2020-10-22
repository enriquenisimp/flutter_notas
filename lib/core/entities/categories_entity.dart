import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class CategoriesEntity implements Equatable{

 final String id;
 final String name;
 final String color;
 final String icon;


 CategoriesEntity(this.id, this.name, this.color, this.icon);


  @override
  // TODO: implement props
  List<Object> get props => [id, name, color, icon];

  @override
  // TODO: implement stringify
  bool get stringify => throw UnimplementedError();


 Map<String, dynamic> toJson() {
   return {
     "id": id,
     "name": name,
     "color": color,
     "icon": icon,
   };
 }
 @override
 String toString() {
   // TODO: implement toString
   return 'Categories{ id: $id, name: $name, color:$color, icon: $icon}';
 }
 static CategoriesEntity fromJson(Map<String, dynamic> json) {
   return CategoriesEntity(
     json["id"] as String,
     json["name"] as String,
     json["color"] as String,
     json["icon"] as String,
   );
 }
}