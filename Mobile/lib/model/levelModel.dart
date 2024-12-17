import 'package:flutter/material.dart';

class LevelModel {
  String logo; // Example: '1+2=3' for level 1
  int level;
  //Color color;
  String stage;

  // Constructor with default values
  LevelModel({
    this.logo = '1+2=3',
    this.level = 1,
   // this.color = Colors.white,
    this.stage='Primary'
  });
}
