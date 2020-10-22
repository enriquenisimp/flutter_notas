import 'package:equatable/equatable.dart';
import 'package:flutter_notas/models/categories.dart';

// This class is responsable of all the events that it allowed in this app.

class CategoryEvent extends Equatable{
  //For start we declare the prototype of construct that will be override for every subclass that need it
  const CategoryEvent();

  //And Implements the prototype of ListObjects method of Equatable, that Like the constructor,
  // will be override for the predecessor.
  @override
  // TODO: implement props
  List<Object> get props => [];

}

//This method ocurred when THe list is completed, not exist any override
// and any change in the data, for this reason don't need be touched
class CategoryLoaded extends CategoryEvent{}

//This method add other item into the list, for this reason it
// need all the information about the item, the object, in this case, TodoObject
class CategoryAdded extends CategoryEvent{
final Categories category;

CategoryAdded(this.category);

@override
  List<Object> get props =>[category];

@override
String toString() => 'CategoryAdded { category: $category }';
}

//This method allow us to change any variable of any item, for this reason need to provided
// what item need to change, and create a comparative with the objects that it have
class CategoryUpdated extends CategoryEvent{
  final Categories category;

  CategoryUpdated(this.category);

  @override
  List<Object> get props =>[category];

  @override
  String toString() => 'CategoryUpdated { updatedCategory: $category }';
}
class CategoryDeleted extends CategoryEvent{
  final Categories category;

  const CategoryDeleted(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() => 'CategoryDeleted { category: $category }';
}
