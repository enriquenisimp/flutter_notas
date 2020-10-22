import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: [
      Chip(label: Text('I')),
      Chip(label: Text('really')),
      Chip(label: Text('really')),
      Chip(label: Text('really')),
      Chip(label: Text('really')),
      Chip(label: Text('really')),
      Chip(label: Text('really')),
      Chip(label: Text('need')),
      Chip(label: Text('a')),
      Chip(label: Text('job')),
    ]);
  }
}
