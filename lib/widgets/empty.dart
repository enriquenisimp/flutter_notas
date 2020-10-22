import 'package:flutter/material.dart';

import '../flutter_todos_keys.dart';

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(key: FlutterTodosKeys.filteredTodosEmptyContainer ,
        child: Center(
            child: Container(
                height: MediaQuery.of(context).size.height*0.6,
                width:MediaQuery.of(context).size.width*0.7,

              child: Column(
                children: [
                  Image.asset("images/empty.png",height:  MediaQuery.of(context).size.height*0.26,),
                  SizedBox(height: 20,),
                  Text("Try to add some task", style: Theme.of(context).textTheme.headline6,)
                ],
              ),
            )));
  }
}
