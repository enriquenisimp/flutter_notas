import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Icongenerator {


  static IconData getIconFromString(String icon) {
    switch(icon)
    {
    case'sunny': return Icons.wb_sunny;
    case'car': return Icons.directions_car;
    case'star': return Icons.star_border;
    case'edit': return Icons.edit;
    }

  }
}