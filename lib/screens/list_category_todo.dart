import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notas/bloc/category/category_bloc.dart';
import 'package:flutter_notas/bloc/category/category_state.dart';
import 'package:flutter_notas/core/routes.dart';
import 'package:flutter_notas/materials/hexcolor.dart';
import 'package:flutter_notas/materials/icon_generator.dart';
import 'package:flutter_notas/models/categories.dart';
import 'file:///C:/Users/qdsoft/Escritorio/flutter_notas/lib/screens/list_todos.dart';
import 'package:flutter_notas/widgets/loading_indicator.dart';

import '../flutter_todos_keys.dart';

class ListCategoryTodo extends StatelessWidget {
  Icongenerator icongenerator;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
            if (state is CategoryLoadSuccess) {
              final categories = state.category;
              print("${categories.length}");
              return ListView.builder(
                itemCount: categories.length,

                itemBuilder: (context, item) {
                  return ListTile(
                  title: Text(categories[item].name),
                  leading: Icon(Icongenerator.getIconFromString(categories[item].icon), color:HexColor("#${categories[item].color}") ,) ,
                  onTap: (){
                    Navigator.pushNamed(context, Routes.listTodos, arguments: categories[item]);
                  }
                );
              },
              );
            }else if(state is CategoryLoadInProgress){
              return LoadingIndicator();
            }else{
              return Container(key: FlutterTodosKeys.filteredTodosEmptyContainer);
          }
        });
  }
}
