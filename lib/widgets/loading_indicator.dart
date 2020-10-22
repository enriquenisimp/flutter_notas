import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color:Colors.grey[800],
            borderRadius: BorderRadius.circular(20)
          ),
            child: CircularProgressIndicator()),
      ),
    );
  }
}
