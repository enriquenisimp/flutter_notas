import 'package:equatable/equatable.dart';
import 'package:flutter_notas/models/categories.dart';

//This class contain all the states that have in this bloc, since waiting any answer until have a good or bad request
class CategoryState extends Equatable{
  const CategoryState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CategoryLoadInProgress extends CategoryState{}

class CategoryLoadSuccess extends CategoryState{
  final List<Categories> category;

  CategoryLoadSuccess([this.category]);

  @override
  List<Object> get props=>[category];

  @override
  String toString() => 'CategoryLoadSuccess { category: $category }';
}

class CategoryLoadFailure extends CategoryState{}