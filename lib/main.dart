import 'package:untitled/login_screen.dart';
import 'package:flutter/material.dart';

import 'lay_out/home_layout.dart';
void main() {
  runApp(MYApp());
}



class MYApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayOut(),
    );
  }

}




