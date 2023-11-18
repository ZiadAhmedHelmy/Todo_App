import 'package:flutter/material.dart';

class Navigation{
  static void goto(BuildContext context , Widget screen){
    Navigator.push(context, MaterialPageRoute(builder:(context)=> screen));
  }
}